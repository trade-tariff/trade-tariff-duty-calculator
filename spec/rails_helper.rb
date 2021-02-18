ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before do
    stub_const('Uktt::Http', FakeUkttHttp)
  end
end
