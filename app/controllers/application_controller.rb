class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorized?, :check_use_https, :set_quick_link_counts, :save_current_url, :set_rss_url, :set_app_information

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
    if authorized?
      @projects_match = Project.match_mine(@my_user.skills).length
    else
      @projects_match = @projects_all_count
    end
  end

  def save_current_url
    session[:current_url] = request.fullpath
  end

  def add_rss_urls(name, url)
    @rss_urls = Array(@rss_urls) << { name: name, url: url }
    @rss_urls.uniq!
  end

  def set_rss_url
    @rss_urls = [{ name: 'ha4go Project List', url: '/feed.rss' }]
  end

  def set_app_information
    @app_infors = AppInformation.order(release: :desc).limit(10)
  end
end
