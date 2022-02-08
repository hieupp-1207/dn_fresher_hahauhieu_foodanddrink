class Admin::OrderDetailsController < Admin::BaseController
  authorize_resource

  def index
    @order = Order.find_by id: params[:order_id]
    @order_details = @order.order_details
  end
end
