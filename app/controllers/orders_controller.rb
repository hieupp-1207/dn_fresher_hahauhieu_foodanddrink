class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :build_order, :build_order_detail, only: :create
  before_action :check_invalid_order, only: %i(new create)

  def new
    if current_cart.empty?
      flash[:danger] = t".please_buy_item"
      redirect_to root_path
    else
      @subtotal_in_cart = subtotal @products
      @current_user
    end
  end

  def create
    @subtotal_in_cart = subtotal @products
    ActiveRecord::Base.transaction do
      @order.save!
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".failed"
    redirect_to carts_path
  else
    current_cart.clear
    flash[:success] = t ".success"
    redirect_to root_path
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
    end
  end

  def check_invalid_order
    count = 0
    product_name = []
    session[:cart].each do |product_id, quantity|
      product = Product.find_by id: product_id
      
      if product.nil?
        current_cart.delete product_id.to_s
        count += 1
      elsif current_cart[product_id] > product.quantity
        product_name << product_name.to_s
      end  
    end
    flash[:danger] = t(".product_deleted", count: count) if count > 0
    unless product_name.empty?
      flash[:warning] = t(".invalid_quantity", names: product_name.join(","))
    end

    @products = Product.by_ids load_products_in_cart
  end
end
