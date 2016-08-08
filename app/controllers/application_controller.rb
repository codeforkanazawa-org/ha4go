class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorized?, :set_quick_link, :set_ranking_link, :set_all_link

  helper_method :authorized?

  private

  def authorized?
    @my_user = User.find(session[:user_id]) if session[:user_id]
    !@my_user.nil?
  end

  def set_quick_link
    @projects_recent_count = Project.recent(Time.now - 30.days).length
  end

  def set_ranking_link
    @projects_hot_rank_count = Project.hot_rank(Time.now - 30.days).length
  end

  def set_all_link
    @projects_all_count = Project.all.count
  end
end
