class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  helper_method :authorized?

  def authorize
      @my_user = get_user_by_session

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

  private

  def get_user_by_session
      if session[:token].nil?
          return nil;
      end

      session_backend = UserSession.find_by token: session[:token]

      if session_backend.nil?
        return nil;
      end

      return User.find(session_backend.user_id);
  end
end
