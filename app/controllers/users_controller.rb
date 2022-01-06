class UsersController < ApplicationController
  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "error.not_found"
    redirect_to root_path
  end
end
