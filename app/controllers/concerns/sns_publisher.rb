# coding: utf-8
module SnsPublisher
  extend ActiveSupport::Concern

  # localhost:3000 などでデバッグしていると必ず失敗するので留意すること
  # (FBが localhost へのリンクを投稿しようとすると必ず失敗するようになっているようだ)
  def publish_to_sns_page(text, uri)
    return if ENV['FACEBOOK_PAGE_SECRET_TOKEN'].nil?
    fb_page = Koala::Facebook::API.new(ENV['FACEBOOK_PAGE_SECRET_TOKEN'])
    logger.debug(text)
    logger.debug(absolute_url(uri))
    fb_page.put_wall_post(text, link: absolute_url(uri))
    true
  rescue => e
    logger.fatal(e.to_s)
    false
  end

  def absolute_url(uri)
    protocol = 'http'
    protocol += 's' if ENV['USE_HTTPS'].to_i > 0
    "#{protocol}://#{ENV['APP_HOST']}#{uri}"
  end
end
