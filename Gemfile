source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.6.5'
gem 'rails', '~> 5.2.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem "jquery-rails"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'devise'
gem 'devise-i18n'
gem 'geocoder'
gem 'dotenv-rails'
gem 'bootstrap', '~> 4.3.1'
gem 'ransack'
gem 'gon'
gem 'kaminari'
gem 'image_processing', '~> 1.2'
gem 'faker'
gem 'unicorn'
gem 'mini_racer', platforms: :ruby
gem 'aws-sdk-s3'
gem "google-cloud"
gem "google-cloud-translate"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
  gem 'capistrano', '3.6.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  # gem 'chromedriver-helper'
  gem 'webdrivers'
  gem 'database_rewinder'
end
