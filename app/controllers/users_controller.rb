class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update show)
  before_action :find_user, except: %i(new create index)

  def show
    @pagy, @user_orders = pagy(@user.orders.sort_orders,
                               items: Settings.per_page_10)
  end

  private

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "error.not_found"
    redirect_to root_path
  end
end
