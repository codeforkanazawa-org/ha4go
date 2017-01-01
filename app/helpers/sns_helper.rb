# coding: utf-8
module SnsHelper
  def facebook_share_btn(url)
    %(<div class="fb-share-button" data-href="#{url}" data-layout="button_count" data-action="like" data-show-faces="true"></div>).html_safe
  end

  def twitter_share_btn(url)
    %(<a class="twitter-share-button" href="#{url}" data-dnt="true">Tweet</a>).html_safe
  end

  def publish_to_sns_page(text)
    return if ENV['FACEBOOK_PAGE_SECRET_TOKEN'].nil?
    fb_page = Koala::Facebook::API.new(ENV['FACEBOOK_PAGE_SECRET_TOKEN'])
    fb_page.put_wall_post(text)
    true
  rescue => e
    logger.fatal(e.to_s)
    false
  end
end
