class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  include SessionsHelper

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = I18n.t "application.login_require"
      redirect_to login_url
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
