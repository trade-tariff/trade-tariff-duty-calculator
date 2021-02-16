require 'rails_helper'

RSpec.describe Commodity do
  subject(:commodity) { described_class.new(code: commodity_code) }

  let(:commodity_code) { '0702000007' }
  let(:url) { "/api/v2/commodities/#{commodity_code}" }
  let(:stubs) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get(url) { |_env| [200, {}, 'egg'] }
    end
  end

  before do
    stubs
  end

  describe 'fetch' do
    it 'foo' do
      binding.pry
      commodity.fetch
    end
  end
end
