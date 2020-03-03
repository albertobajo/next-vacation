source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# ActiveRecord connection adapter for PostGIS
gem 'activerecord-postgis-adapter', '~> 6.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Strategies for cleaning databases. Can be used to ensure a clean state for testing.
  gem 'database_cleaner', '~> 1.7'
  # Provides integration between factory_bot and rails 4.2 or newer
  gem 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  # Easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker', '~> 2.7'
  # Ruby JSON Schema Validator
  gem 'json-schema', '~> 2.8', '>= 2.8.1'
  # rspec-rails brings the RSpec testing framework to Ruby on Rails
  gem 'rspec-rails', '~> 4.0.0.beta3'
  # One-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.2'
end

group :development do
  # Automatically run your specs (much like autotest).
  gem 'guard', '~> 2.16', '>= 2.16.1', require: false
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Supporting gem for Rails Panel
  gem 'meta_request', '~> 0.7.2'
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
