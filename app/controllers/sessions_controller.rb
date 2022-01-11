class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t ".login_success"
      log_in user
      redirect_to root_path
    else
      flash.now[:warning] = t ".login_fail"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
