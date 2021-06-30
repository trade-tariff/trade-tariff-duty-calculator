source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6'

# Use Puma as the app server
gem 'puma'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Manage multiple processes i.e. web server and webpack
gem 'foreman'

# Canonical meta tag
gem 'canonical-rails'
gem 'lograge'
gem 'logstash-event'

# GOV.UK form builder tool
gem 'govuk_design_system_formbuilder', '= 2.4.0'

# API client for the trade tariff api
gem 'uktt', git: 'https://github.com/trade-tariff/uktt.git'

# Sentry for errors tracking
gem 'sentry-raven'

# New Relic for apm and logging
gem 'newrelic_rpm'

group :development, :test do
  gem 'brakeman'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rubocop-govuk'
  gem 'scss_lint-govuk'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end
