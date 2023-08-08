source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'actionpack', '~> 7'
gem 'actionview', '~> 7'
gem 'activemodel', '~> 7'
gem 'activerecord', '~> 7'
gem 'activesupport', '~> 7'
gem 'bootsnap', require: false
gem 'foreman'
gem 'govspeak'
gem 'govuk_design_system_formbuilder'
gem 'lograge'
gem 'logstash-event'
gem 'newrelic_rpm'
gem 'puma'
gem 'railties', '~> 7'
gem 'sentry-rails'
gem 'uktt', git: 'https://github.com/trade-tariff/uktt.git'
gem 'webpacker'

gem 'multipart-post', '= 2.2.3'

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
