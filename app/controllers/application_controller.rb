class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  def authorize
      if authorized?
        @my_user = User.find(1)
      else
        @my_user = nil
      end
  end

  def authorized?
      # TODO セッション判定処理
      return false
  end
end
