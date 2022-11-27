# coding: utf-8
class PostToSnsJob < ActiveJob::Base
  queue_as :default

  def perform(text, uri, name, description, _image)
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
