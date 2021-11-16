# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'books'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2', '>= 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# allows the use of locales
gem 'i18n', '~> 1.8', '>= 1.8.11'

# Template
gem 'bootstrap', '~> 5.0.2'
gem 'haml', '~> 5.2', '>= 5.2.2'
gem 'haml-rails', '~> 2.0', '>= 2.0.1'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2'
  # Check style in tests
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2', require: false
  gem 'rubocop-rspec', '~> 2.6', require: false
  # RSpec results that continuous integration service can read.
  gem 'rspec_junit_formatter', '~> 0.4.1'
  # fake data
  gem 'faker', '~> 2.19'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Check style
  gem 'brakeman', '~> 5.1', '>= 5.1.2', require: false
  gem 'rubocop', '~> 1.22', '>= 1.22.3', require: false
  gem 'rubocop-rails', '~> 2.12', '>= 2.12.4', require: false
  # Check perfomance
  gem 'fasterer', '~> 0.9.0', require: false
  gem 'rubocop-performance', '~> 1.12', require: false
  # Check DB
  gem 'bullet', '~> 6.1', '>= 6.1.5'
  gem 'database_consistency', '~> 1.1', '>= 1.1.5', require: false
  # Pre-commit check
  gem 'lefthook', '~> 0.7.7', require: false
  # Check dependency
  gem 'bundler-audit', '~> 0.9.0.1', require: false
  # annotation in models
  gem 'annotate', '~> 3.1', '>= 3.1.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '~> 4.0', '>= 4.0.3'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '~> 5.0'
  # Tests
  gem 'rspec', '~> 3.10'
  gem 'shoulda-matchers', '~> 5.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
