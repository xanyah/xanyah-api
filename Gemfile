# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.5.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# dotenv first to load environment variables everywhere
gem 'dotenv-rails', groups: %i[development test]

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.2.1'

gem 'active_model_serializers', '~> 0.10.7'
gem 'aws-sdk-s3', require: false
gem 'cancancan', '~> 2.0'
gem 'devise_token_auth'
gem 'faker', github: 'stympy/faker'
gem 'paranoia', '~> 2.2'
gem 'rack-cors'
gem 'redis-namespace'
gem 'sidekiq'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'apitome', require: false
  gem 'codeclimate-test-reporter', '~> 1.0', '>= 1.0.8'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.6'
  gem 'rspec-sidekiq'
  gem 'rspec_api_documentation'
  gem 'simplecov'
  gem 'simplecov-console'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
