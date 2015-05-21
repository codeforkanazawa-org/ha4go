class AuthController < ApplicationController
  def login
  end

  def login_check
      @user = User.find_by email: params[:login][:email]
      if authorized_user? 
        create_session_and_redirect_top
      else
        redirect_to login_path
      end
  end

  def create_session_and_redirect_top
      token = get_session_token

      session_backend = UserSession.new(:user_id => @user.id, :token => token)

      if session_backend.save
          session[:token] = token
          redirect_to root_path
      else
          redirect_to login_path
      end
  end

  def signup
  end

  def signup_check
      if create_user
          create_session_and_redirect_top
      else
          redirect_to signup_path
      end
  end

  def logout
      session[:token] = nil
      redirect_to root_path
  end

  private

  def get_session_token
      return Digest::SHA1.hexdigest("#{Time.now.to_s}#{@user.password}")
  end

  def authorized_user?
    if @user.nil?
        return false
    end

    if @user.password != get_hash(params[:login][:password])
        return false
    end

    return true
  end

  def create_user
      signup_params = params[:signup]
      @user = User.new(:name => '名前未設定', :email => signup_params[:email], :password => get_hash(signup_params[:password]))

      begin
        return @user.save
      rescue
          return false
      end
  end

  def get_hash string
      return Digest::MD5.hexdigest(string)
  end

end
