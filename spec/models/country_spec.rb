require 'rails_helper'

RSpec.describe Country do
  subject(:country) { described_class.new(attributes) }

  let(:attributes) { OpenStruct.new(geographical_area_id: 'FO', description: 'bar') }
  let(:uktt_country) { instance_double('Uktt::Country') }
  let(:response) { double }
  let(:foo_country) { double(attributes: double(geographical_aread_id: 'FO', description: 'foo')) }
  let(:bar_country) { double(attributes: double(geographical_aread_id: 'BA', description: 'bar')) }
  let(:countries) { [foo_country, bar_country] }

  before do
    allow(Uktt::Country).to receive(:new).and_return(uktt_country)
    allow(uktt_country).to receive(:retrieve)
    allow(uktt_country).to receive(:response).and_return(response)
    allow(response).to receive(:data).and_return(countries)
  end

  describe '#id' do
    it 'returns the name from the attributes' do
      expect(country.id).to eq('FO')
    end
  end

  describe '#name' do
    it 'returns the name from the attributes' do
      expect(country.name).to eq('bar')
    end
  end

  describe '.list' do
    it 'returns the expected sorted list of countries' do
      expect(described_class.list.map(&:name)).to eq(%w[bar foo])
    end
  end

  describe '.eu_member?' do
    it 'returns true if the country is part of EU' do
      expect(described_class.eu_member?('IE')).to be true
    end

    it 'returns false if the country is not part of EU' do
      expect(described_class.eu_member?('GB')).to be false
    end
  end

  describe '.response' do
    it 'calls Uktt::Country#retrieve' do
      described_class.response(:xi)

      expect(uktt_country).to have_received(:retrieve)
    end

    it 'calls Uktt::Country#response' do
      described_class.response(:xi)

      expect(uktt_country).to have_received(:response)
    end

    it 'returns Uktt::Country#response' do
      expect(described_class.response(:xi)).to eq(response)
    end

    it 'calls Uktt::Country.new with the correct options' do
      described_class.response(:xi)

      expect(Uktt::Country).to have_received(:new).with(
        host: 'https://dev.trade-tariff.service.gov.uk/xi',
        version: 'v2',
        debug: false,
        return_json: false,
      )
    end
  end
end
