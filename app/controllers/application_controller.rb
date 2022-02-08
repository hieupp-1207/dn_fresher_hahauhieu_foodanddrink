class ApplicationController < ActionController::Base
  before_action :set_locale, :load_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied, with: :cancan_access_denied

  include SessionsHelper
  include Pagy::Backend

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    check_locales = I18n.available_locales.include?(locale)
    I18n.locale = check_locales ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_cart
    session[:cart] ||= {}
  end

  def logged_in_user
    return if current_user.present?

    store_location
    flash[:danger] = t "errors.not_login"
    redirect_to login_url
  end

  def configure_permitted_parameters
    added_attrs = [:fullname, :email, :password, :password_confirmation,
      :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def cancan_access_denied
    flash[:danger] = t "cancan.permission_denied"
    redirect_to root_url
  end
end
