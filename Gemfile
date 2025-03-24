source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'rails', '~> 8.0'

gem 'bootsnap', require: false
gem 'foreman'
gem 'govspeak'
gem 'govuk_design_system_formbuilder'
gem 'lograge'
gem 'logstash-event'
gem 'newrelic_rpm'
gem 'puma'
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
  gem 'awesome_print'
  gem 'listen'
  gem 'ruby-lsp-rails'
  gem 'ruby-lsp-rspec'
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
