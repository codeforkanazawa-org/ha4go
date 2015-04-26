class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  helper_method :authorized?

  def authorize
      begin
          @my_user = User.find(session[:user_id])
      rescue
          @my_user = nil
      end

      # 名前が未設定だったらプロフィールへ
      if authorized? && @my_user.name.nil?
          redirect_to user_path(:id => @my_user.id)
      end
  end

  def authorized?
      if @my_user
          return true
      else
          return false
      end
  end
end
