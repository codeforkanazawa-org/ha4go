class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorized?, :check_use_https, :set_quick_link_counts

  helper_method :authorized?

  private

  def default_duration
    Time.now - 30.days
  end

  def authorized?
    @my_user = User.find(session[:user_id]) if session[:user_id]
    !@my_user.nil?
  end

  def check_use_https
    request.env['HTTP_X_FORWARDED_SSL'] = 'on' if ENV['USE_HTTPS'].to_i >= 1
  end

  def set_quick_link_counts
    @projects_recent_count = Project.recent(default_duration).length
    @projects_hot_rank_count = Project.hot_rank(default_duration).length
    @projects_all_count = Project.all.count
    @projects_recruiting_count = Project.recruiting.length
  end
end
