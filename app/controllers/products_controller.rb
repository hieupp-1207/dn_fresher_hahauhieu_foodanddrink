class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy Product.all.newest, items: Settings.number.digit_12
  end
end
