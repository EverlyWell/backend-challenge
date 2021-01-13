source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bcrypt'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'faraday'
gem 'fast_jsonapi'
gem 'jwt'
gem 'jsonapi_parameters'
gem 'light-service'
gem 'oj'
gem 'rails', '~> 6.1.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'sidekiq'


group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7.5'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec_api_documentation'
  gem 'rspec-json_expectations', '~> 2.2'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.3'
  gem 'guard-rspec', require: false
  gem 'rails-erd', github: 'guapolo/rails-erd'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end
