class CartsController < ApplicationController
  before_action :load_product, :check_quantity, only: :create
  skip_before_action :verify_authenticity_token
  
  def create
    add_product_to_cart params[:product_id], params[:quantity]
    flash[:success] = t ".add_success"
    redirect_to product_path params[:product_id]
  end

  def index
    @products = Product.by_ids load_products_in_cart
    @subtotal_in_cart = subtotal @products
  end

  private

  def check_quantity
    quantity_card = current_cart[params[:product_id]] || 0
    return if @product.quantity >= (params[:quantity].to_i + quantity_card.to_i)

    flash[:danger] = t "errors.not_enough"
    redirect_to product_path params[:product_id]
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product

    flash[:danger] = t "error.not_found_product"
    redirect_to root_path
  end
end
