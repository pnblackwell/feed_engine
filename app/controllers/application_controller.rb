class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    unless logged_in?
      flash[:error] = "Please log in first"
      redirect_to root_url(:subdomain => false)
    end
  end

  def logged_in?
    !!current_user
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
