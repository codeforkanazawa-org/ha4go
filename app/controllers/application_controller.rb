class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorized?

  helper_method :authorized?

  private

  def authorized?
        @my_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
