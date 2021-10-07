RSpec.describe Api::Base do
  before do
    allow(Rails.application.config.http_client_uk).to receive(:retrieve).and_call_original
    allow(Rails.application.config.http_client_xi).to receive(:retrieve).and_call_original
  end

  describe '#build' do
    subject(:api_resource) { Api::Commodity }

    let(:id) { '0103921100' }
    let(:query) { { foo: :bar } }

    context 'when the service is uk' do
      let(:service) { 'uk' }

      it 'calls the uk client with the correct params' do
        api_resource.build(service, id, query)

        expect(Rails.application.config.http_client_uk).to have_received(:retrieve).with('commodities/0103921100.json', 'as_of' => Time.zone.today.iso8601, foo: :bar)
      end
    end

    context 'when the service is xi' do
      let(:service) { 'xi' }

      it 'calls the xi client with the correct params' do
        api_resource.build(service, id, query)

        expect(Rails.application.config.http_client_xi).to have_received(:retrieve).with(
          'commodities/0103921100.json',
          'as_of' => Time.zone.today.iso8601,
          foo: :bar,
        )
      end
    end
  end

  describe '#build_collection' do
    subject(:api_resource) { Api::GeographicalArea }

    let(:service) { 'uk' }
    let(:klass_override) { nil }
    let(:query) { { foo: :bar } }

    context 'when the service is uk' do
      let(:service) { 'uk' }

      it 'calls the uk client with the correct params' do
        api_resource.build_collection(service, klass_override, query)

        expect(Rails.application.config.http_client_uk).to have_received(:retrieve).with(
          'geographical_areas.json',
          'as_of' => Time.zone.today.iso8601,
          foo: :bar,
        )
      end
    end

    context 'when the service is xi' do
      let(:service) { 'xi' }

      it 'calls the xi client with the correct params' do
        api_resource.build_collection(service, klass_override, query)

        expect(Rails.application.config.http_client_xi).to have_received(:retrieve).with(
          'geographical_areas.json',
          'as_of' => Time.zone.today.iso8601,
          foo: :bar,
        )
      end
    end

    context 'when providing a klass override' do
      let(:klass_override) { 'Country' }

      it 'calls the uk client with the correct params' do
        api_resource.build_collection(service, klass_override, query)

        expect(Rails.application.config.http_client_uk).to have_received(:retrieve).with(
          'geographical_areas/countries.json',
          'as_of' => Time.zone.today.iso8601,
          foo: :bar,
        )
      end
    end
  end
end
