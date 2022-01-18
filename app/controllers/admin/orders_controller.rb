class Admin::OrdersController < Admin::BaseController
  def index
    @pagy, @orders = pagy Order.sort_orders, items: Settings.per_page_10
  end

  private

  def find_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t ".not_found_order"
    redirect_to admin_orders_path
  end
end
