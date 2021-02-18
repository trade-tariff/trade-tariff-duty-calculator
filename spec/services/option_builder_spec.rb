require 'rails_helper'

RSpec.describe OptionBuilder do
  subject(:builder) { described_class.new(service, commodity_code) }

  let(:api_options) do
    { uk: 'http://uk.localhost:3018', xi: 'http://xi.localhost:3019' }
  end

  before do
    allow(Rails.application.config).to receive(:api_options).and_return(api_options)
  end

  describe '#call' do
    let(:commodity_code) { '1234567890' }

    context 'when the service is uk' do
      let(:service) { :uk }

      it 'returns the correct service configuration' do
        expect(builder.call).to include(
          host: 'http://uk.localhost:3018',
          version: 'v2',
          debug: false,
          return_json: false,
          commodity_id: commodity_code,
        )
      end
    end

    context 'when the service is xi' do
      let(:service) { :xi }

      it 'returns the correct service configuration' do
        expect(builder.call).to include(
          host: 'http://xi.localhost:3019',
          version: 'v2',
          debug: false,
          return_json: false,
          commodity_id: commodity_code,
        )
      end
    end
  end
end
