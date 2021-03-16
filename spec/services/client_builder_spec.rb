RSpec.describe ClientBuilder do
  subject(:builder) { described_class.new(service) }

  let(:api_options) do
    { uk: 'http://uk.localhost:3018', xi: 'http://xi.localhost:3019' }
  end

  before do
    allow(Rails.application.config).to receive(:api_options).and_return(api_options)
  end

  describe '#call' do
    before do
      allow(Uktt::Http).to receive(:build)
    end

    context 'when the service is uk' do
      let(:service) { :uk }

      it 'passes the correct configuration' do
        builder.call

        expect(Uktt::Http).to have_received(:build).with(
          'http://uk.localhost:3018',
          'v2',
          'jsonapi',
        )
      end
    end

    context 'when the service is xi' do
      let(:service) { :xi }

      it 'passes the correct configuration' do
        builder.call

        expect(Uktt::Http).to have_received(:build).with(
          'http://xi.localhost:3019',
          'v2',
          'jsonapi',
        )
      end
    end
  end
end
