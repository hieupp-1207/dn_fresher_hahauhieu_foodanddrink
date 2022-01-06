class CartsController < ApplicationController
  before_action :load_product, only: :create

  def create
    add_food_to_cart(params[:product_id], params[:quantity]) if check_quantity?
    respond_to do |format|
      format.js
    end
  end

  private

  def check_quantity?
    @product.quantity >= params[:quantity].to_i
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product

    flash[:danger] = t "error.not_found_product"
    redirect_to root_path
  end
end
