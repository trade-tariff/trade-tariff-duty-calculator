source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'bootsnap', require: false
gem 'canonical-rails'
gem 'foreman'
gem 'govuk_design_system_formbuilder', '= 2.4.0'
gem 'lograge'
gem 'logstash-event'
gem 'newrelic_rpm'
gem 'puma'
gem 'rails', '~> 6'
gem 'sentry-raven'
gem 'uktt', git: 'https://github.com/trade-tariff/uktt.git'
gem 'webpacker'

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
