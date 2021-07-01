source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '3.0.1'

# Base
gem 'rails', '~> 6.1.4'
gem 'pg'
gem 'puma'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end
