class ApplicationController < ActionController::Base
  before_action :set_locale, :load_cart

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
end
