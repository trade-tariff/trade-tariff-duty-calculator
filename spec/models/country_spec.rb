require 'rails_helper'

RSpec.describe Country do
  subject(:country) { described_class.new }

  let(:uktt_country) { instance_double('Uktt::Country') }

  let(:response) { double }
  let(:foo_country) { double(attributes: double(description: 'foo')) }
  let(:bar_country) { double(attributes: double(description: 'bar')) }
  let(:countries) { [foo_country, bar_country] }

  before do
    allow(Uktt::Country).to receive(:new).and_return(uktt_country)
    allow(uktt_country).to receive(:retrieve)
    allow(uktt_country).to receive(:response).and_return(response)
    allow(response).to receive(:data).and_return(countries)
  end

  describe '#list' do
    it 'returns the expected sorted list of countries' do
      expect(country.list).to eq(%w[bar foo])
    end
  end

  describe '#response' do
    it 'calls Uktt::Country#retrieve' do
      country.response

      expect(uktt_country).to have_received(:retrieve)
    end

    it 'calls Uktt::Country#response' do
      country.response

      expect(uktt_country).to have_received(:response)
    end

    it 'returns Uktt::Country#response' do
      expect(country.response).to eq(response)
    end

    context 'when the xi service is specified' do
      subject(:country) { described_class.new(service: :xi) }

      it 'calls Uktt::Country.new with the correct options' do
        country.response

        expect(Uktt::Country).to have_received(:new).with(
          host: 'https://dev.trade-tariff.service.gov.uk/xi',
          version: 'v2',
          debug: false,
          return_json: false,
        )
      end
    end

    context 'when no service is specified' do
      subject(:country) { described_class.new }

      it 'calls Uktt::Country.new with the correct options' do
        country.response

        expect(Uktt::Country).to have_received(:new).with(
          host: 'https://dev.trade-tariff.service.gov.uk',
          version: 'v2',
          debug: false,
          return_json: false,
        )
      end
    end
  end
end
