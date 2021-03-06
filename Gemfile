source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.1'

# Use Puma as the app server
gem 'puma', '~> 5.2'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Manage multiple processes i.e. web server and webpack
gem 'foreman'

# Canonical meta tag
gem 'canonical-rails'

# Logging
gem 'lograge'
gem 'logstash-event'

# GOV.UK form builder tool
gem 'govuk_design_system_formbuilder'

# API client for the trade tariff api
gem 'uktt', '~> 0.6.0', git: 'https://github.com/trade-tariff/uktt.git'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # GOV.UK interpretation of rubocop for linting Ruby
  gem 'rubocop-govuk'
  gem 'scss_lint-govuk'

  # Debugging
  gem 'pry-byebug'
  gem 'pry-rails'

  # Testing framework
  gem 'rspec-rails', '~> 4.0.2'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.35'

  gem 'dotenv-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.5'
  gem 'web-console', '>= 3.3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'webdrivers', '~> 4.5'
end
