source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'rails-api'
gem 'mysql2'
gem 'auto_increment'
gem 'active_model_serializers', '~> 0.9.5'
gem 'redis'
gem 'redis-rails'
gem 'redis-rack-cache'
gem 'sidekiq'
gem 'sinatra', require: nil

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'byebug'
  gem 'dotenv-rails'
end

group :development do
  gem 'rubocop', require: false
  gem 'spring'
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'foreman'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'json_matchers'
  gem 'rspec-sidekiq'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
end
