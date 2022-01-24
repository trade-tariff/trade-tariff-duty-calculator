source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'actionpack', '~> 6'
gem 'actionview', '~> 6'
gem 'activemodel', '~> 6'
gem 'activerecord', '~> 6'
gem 'activesupport', '~> 6'
gem 'bootsnap', require: false
gem 'foreman'
gem 'govuk_design_system_formbuilder', '3.0.1'
gem 'lograge'
gem 'logstash-event'
gem 'newrelic_rpm'
gem 'puma'
gem 'railties', '~> 6'
gem 'sentry-rails'
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
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
