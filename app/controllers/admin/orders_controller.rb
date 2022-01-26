class Admin::OrdersController < Admin::BaseController
  include ActionView::Helpers::UrlHelper

  before_action :find_order, :valid_status?, only: %i(update)

  def index
    @pagy, @orders = pagy Order.sort_orders, items: Settings.per_page_10
  end

  def update
    ActiveRecord::Base.transaction do
      @order.update! status: status_params.to_i
      @order.update_quantity_product if @order.rejected?
    end
    flash[:success] = t ".update_status_success"
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".update_status_fail"
  ensure
    redirect_to request.referer
  end

  private

  def find_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t ".not_found_order"
    redirect_to admin_orders_path
  end

  def valid_status?
    current_status = Order.statuses[@order.status]
    change_status = params[:status].to_i
    return if Order.statuses.values.include?(change_status) &&
              change_status - current_status >= 1

    flash[:danger] = t ".update_status_invalid"
    redirect_to admin_orders_path
  end

  def status_params
    params.require(:status)
  end
end
