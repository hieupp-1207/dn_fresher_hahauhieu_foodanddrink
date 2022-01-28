class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_invalid_order, only: %i(new create)
  before_action :build_order, :build_order_detail, only: :create
  before_action :find_order, only: :show

  def new
    if current_cart.empty?
      flash[:danger] = t ".please_buy_item"
      redirect_to root_path
    else
      @current_user
    end
  end

  def create
    ActiveRecord::Base.transaction do
      @order.save!
    end
    current_cart.clear
    flash[:success] = t ".success"
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".failed"
    redirect_to carts_path
  end

  def show
    @order_details = @order.order_details.sort_by_created_at
  end

  private

  def build_order
    @order = current_user.orders.build(
      address: params[:address],
      phone: params[:phone],
      total_price: @subtotal_in_cart
    )
  end

  def build_order_detail
    current_cart.each do |product_id, quantity|
      product = Product.find_by id: product_id
      next if product.nil?

      @order.order_details.build(
        quantity: quantity,
        price: product.price * quantity.to_i,
        product_id: product_id
      )
      remain_quantity = product.quantity - quantity
      product.update! quantity: remain_quantity
    end
  end

  def check_invalid_order
    count = 0
    product_name = []
    session[:cart].each do |product_id, _quantity|
      product = Product.find_by id: product_id

      if product.nil?
        current_cart.delete product_id.to_s
        count += 1
      elsif current_cart[product_id] > product.quantity
        product_name << product_name.to_s
      end
    end

    invalid_message count, product_name
    @products = Product.by_ids load_products_in_cart
    @subtotal_in_cart = subtotal @products
  end

  def invalid_message count, product_name
    flash[:danger] = t(".product_deleted", count: count) if count.positive?
    return if product_name.empty?

    flash[:warning] = t(".invalid_quantity", names: product_name.join(","))
  end

  def find_order
    @order = Order.includes(:order_details).find_by id: params[:id]
    return if @order

    flash[:warning] = t "error.not_found_order"
    redirect_to root_path
  end
end
