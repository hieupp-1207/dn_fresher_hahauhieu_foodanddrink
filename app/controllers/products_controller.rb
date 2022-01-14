class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    products = Product.search(params[:term]).newest
    @pagy, @products = pagy products, items: Settings.number.digit_12
  end

  def show; end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t "errors.not_found_product"
    redirect_to root_path
  end
end
