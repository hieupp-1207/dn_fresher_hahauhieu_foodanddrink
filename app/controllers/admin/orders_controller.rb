class Admin::OrdersController < Admin::BaseController
  def index
    @pagy, @orders = pagy Order.sort_orders, items: Settings.per_page_10
  end
end
