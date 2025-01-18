# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.8'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# dotenv first to load environment variables everywhere
gem 'dotenv-rails', '~> 2.5', groups: %i[development test]

gem 'pg', '~> 0.21'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2'

gem 'ffi', '< 1.17.0'

gem 'active_model_serializers', '~> 0.10'
gem 'aws-sdk-s3', '~> 1.19', require: false
gem 'cancancan', '~> 2.3'
gem 'devise_token_auth', '~> 0.2'
gem 'faker', '1.9.1'
gem 'paranoia', '~> 2.4'
gem 'rack-cors', '~> 1.0'
gem 'redis-namespace', '~> 1.6'
gem 'sidekiq', '~> 5.2'

group :development, :test do
  # Use database cleaner to delete records after each test
  gem 'database_cleaner-active_record', '~> 2.2'
  # Use Factorybot for test factories
  gem 'factory_bot_rails', '~> 6.4'

  gem 'rubocop', '~> 1.70', require: false
  gem 'rubocop-factory_bot', '~> 2.26', require: false
  # gem 'rubocop-i18n', github: 'puppetlabs/rubocop-i18n', require: false
  gem 'rubocop-performance', '~> 1.23', require: false
  gem 'rubocop-rails', '~> 2.28', require: false
  gem 'rubocop-rspec_rails', '~> 2.30', require: false
  gem 'rubocop-thread_safety', '~> 0.6', require: false
end

group :test do
  gem 'apitome', '~> 0.2', require: false
  gem 'rspec_api_documentation', '~> 6.0'
  gem 'rspec-rails', '~> 3.8'
  gem 'rspec-sidekiq', '~> 3.0'
  gem 'simplecov', '~> 0.13'
  gem 'simplecov-console', '~> 0.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
