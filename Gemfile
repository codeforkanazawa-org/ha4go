# coding: utf-8
source 'https://rubygems.org'

ruby '~> 2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', groups: %w(test development), require: false
# gem 'pg', groups: %w(production), require: false
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass', '~> 3.4.1'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'puma'

# gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'meta-tags'

gem 'sendgrid-ruby'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'

  gem 'rubocop', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'dotenv-rails'

  gem 'rails-erd'
end

group :development do
  gem 'letter_opener'
  gem 'letter_opener_web'
end

gem 'rails-controller-testing', group: :test

group :production do
  # gem 'pg'
end

# Herokuログ出力用
gem 'rails_12factor', group: :production

#gem 'compass', :git => 'git://github.com/chriseppstein/compass.git'
gem 'compass'
gem 'compass-rails' #, :git => 'git://github.com/Compass/compass-rails.git'

gem 'google-analytics-rails'

# gem 'koala', '~> 2.2'
gem 'koala'

# for Image upload
# gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'carrierwave', '~> 1.0'
gem 'rmagick', '~> 2.0'

gem 'fog-aws'

# backgroud job
gem 'delayed_job_active_record'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'kaminari'

gem 'rubocop-performance'

gem 'net-http-persistent'
