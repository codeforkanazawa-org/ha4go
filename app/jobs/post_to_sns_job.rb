# coding: utf-8
class PostToSnsJob < ActiveJob::Base
  queue_as :default

  def perform(text, uri, name, description, _image)
    # localhost:3000 などでデバッグしていると必ず失敗するので留意すること
    # (FBが localhost へのリンクを投稿しようとすると必ず失敗するようになっているようだ)
    fb_page = Koala::Facebook::API.new(ENV['FACEBOOK_PAGE_SECRET_TOKEN'])
    # params are to see http://www.rubydoc.info/github/arsduo/koala/Koala%2FFacebook%2FGraphAPIMethods%3Aput_wall_post
    post_params = {
      link:        absolute_url(uri),
      name:        name,
      description: description
    }
    post_params.each do |k, v|
      logger.debug("[PUT_WALL_POST] #{k} : #{v}")
    end
    logger.debug("[PUT_WALL_POST] #{text}")
    fb_page.put_wall_post(text, post_params)
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
