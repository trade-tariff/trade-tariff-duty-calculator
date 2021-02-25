require 'rails_helper'

RSpec.describe OptionBuilder do
  subject(:builder) { described_class.new(service) }

  let(:api_options) do
    { uk: 'http://uk.localhost:3018', xi: 'http://xi.localhost:3019' }
  end

  before do
    allow(Rails.application.config).to receive(:api_options).and_return(api_options)
  end

  describe '#call' do
    context 'when the service is uk' do
      let(:service) { :uk }

      it 'returns the correct service configuration' do
        expect(builder.call).to include(
          host: 'http://uk.localhost:3018',
          version: 'v2',
          debug: false,
          format: 'jsonapi',
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
          format: 'jsonapi',
        )
      end
    end
  end
end
