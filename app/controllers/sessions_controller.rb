# coding: utf-8
class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to session[:current_url], notice: "ログインしました"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "ログアウトしました"
  end

  # overrideしてこのコントローラではURLを保存しないようにする
  def save_current_url
  end
end
