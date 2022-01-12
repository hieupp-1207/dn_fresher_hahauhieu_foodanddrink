class StaticPagesController < ApplicationController
  def home
    @products = Product.newest.limit_8
  end
end
