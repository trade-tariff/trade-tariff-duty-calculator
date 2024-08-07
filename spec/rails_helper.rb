ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start do
    minimum_coverage 90
    maximum_coverage_drop 0.25
    add_filter '/spec/'
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.example_status_persistence_file_path = 'rspec.txt'
  config.expose_dsl_globally = false
  config.include FactoryBot::Syntax::Methods
  config.include Rails.application.routes.url_helpers, :step
  config.before do
    Thread.current[:commodity_context_service] = CommodityContextService.new

    Rails.application.config.http_client_uk = FakeUkttHttp.new(nil, 'uk', nil, nil)
    Rails.application.config.http_client_xi = FakeUkttHttp.new(nil, 'xi', nil, nil)

    stub_const('Uktt::Http', FakeUkttHttp)
  end

  config.before :each, :user_session do
    allow(UserSession).to receive_messages(build: user_session, build_from_params: user_session, get: user_session)
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
