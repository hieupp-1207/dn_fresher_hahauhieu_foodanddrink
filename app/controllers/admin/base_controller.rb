class Admin::BaseController < ApplicationController
  before_action :require_admin

  layout "admin/layouts/application"

  def require_admin
    return if current_user.admin?

    flash[:danger] = t ".forbiden"
    redirect_to root_path
  end
end
