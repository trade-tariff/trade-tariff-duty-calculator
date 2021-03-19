require 'rails_helper'

RSpec.describe ServiceHelper do
  before do
    allow(Rails.configuration).to receive(:trade_tariff_frontend_url).and_return(frontend_url)

    allow(controller).to receive(:params).and_return(params)
  end

  let(:params) do
    ActionController::Parameters.new(
      referred_service: service,
    ).permit(:referred_service)
  end

  let(:service) { 'uk' }

  let(:frontend_url) { 'https://dev.trade-tariff.service.gov.uk' }

  describe '#trade_tariff_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff url' do
        expect(helper.trade_tariff_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/sections',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the staging trade tariff url' do
        expect(helper.trade_tariff_url).to eq('#')
      end
    end

    context 'when service choice is XI' do
      let(:service) { 'xi' }

      it 'returns the dev trade tariff url for XI' do
        expect(helper.trade_tariff_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/xi/sections',
        )
      end
    end
  end

  describe '#a_to_z_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff a to z url' do
        expect(helper.a_to_z_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/a-z-index/a',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff a to z url' do
        expect(helper.a_to_z_url).to eq('#')
      end
    end
  end

  describe '#tools_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff tools url' do
        expect(helper.tools_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/tools',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff tools url' do
        expect(helper.tools_url).to eq('#')
      end
    end
  end

  describe '#commodity_url' do
    let(:commodity_code) { '1234567890' }

    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff tools url' do
        expect(helper.commodity_url(commodity_code)).to eq(
          "https://dev.trade-tariff.service.gov.uk/commodities/#{commodity_code}",
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff tools url' do
        expect(helper.commodity_url(commodity_code)).to eq('#')
      end
    end
  end
end
