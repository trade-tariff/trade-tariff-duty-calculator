require 'rails_helper'

RSpec.describe Commodity do
  subject(:commodity) { described_class.new(code: commodity_code) }

  let(:commodity_code) { '0702000007' }
  let(:uktt_commodity) { instance_double('Uktt::Commodity') }
  let(:response) { double(data: double(attributes: double(description: 'Cherry Tomatoes'))) }

  before do
    allow(Uktt::Commodity).to receive(:new).and_return(uktt_commodity)
    allow(uktt_commodity).to receive(:retrieve)
    allow(uktt_commodity).to receive(:response).and_return(response)
  end

  describe '#description' do
    it 'returns the expected description' do
      expect(commodity.description).to eq('Cherry Tomatoes')
    end
  end

  describe '#response' do
    it 'calls Uktt::Commodity#retrieve' do
      commodity.response

      expect(uktt_commodity).to have_received(:retrieve)
    end

    it 'calls Uktt::Commodity#response' do
      commodity.response

      expect(uktt_commodity).to have_received(:response)
    end

    it 'returns Uktt::Commodity#response' do
      expect(commodity.response).to eq(response)
    end

    context 'when the xi service is specified' do
      subject(:commodity) { described_class.new(code: commodity_code, service: :xi) }

      it 'calls Uktt::Commodity.new with the correct options' do
        commodity.response

        expect(Uktt::Commodity).to have_received(:new).with(
          host: 'https://dev.trade-tariff.service.gov.uk/xi',
          version: 'v2',
          debug: false,
          commodity_id: commodity_code,
          return_json: false,
        )
      end
    end

    context 'when no service is specified' do
      subject(:commodity) { described_class.new(code: commodity_code) }

      it 'calls Uktt::Commodity.new with the correct options' do
        commodity.response

        expect(Uktt::Commodity).to have_received(:new).with(
          host: 'https://dev.trade-tariff.service.gov.uk',
          version: 'v2',
          debug: false,
          commodity_id: commodity_code,
          return_json: false,
        )
      end
    end
  end
end
