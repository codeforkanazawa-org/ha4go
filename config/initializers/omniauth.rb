OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
           ENV['FACEBOOK_APP_ID'],
           ENV['FACEBOOK_APP_SECRET'],
           client_options: {
             site: 'https://graph.facebook.com/v2.8',
             authorize_url: "https://www.facebook.com/v2.8/dialog/oauth"
           },
           secure_image_url: true,
           image_siez: :large
end
