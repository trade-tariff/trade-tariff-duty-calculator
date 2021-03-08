ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    minimum_coverage 90
    maximum_coverage_drop 0.25
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.example_status_persistence_file_path = 'rspec.txt'

  config.before do
    stub_const('Uktt::Http', FakeUkttHttp)
  end
end
