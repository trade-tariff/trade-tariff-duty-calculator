require 'rails_helper'

RSpec.describe ServiceHelper do
  before do
    allow(Rails.configuration).to receive(:trade_tariff_frontend_origin).and_return(environment)
  end

  describe 'trade_tariff_url' do
    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to development' do
      let(:environment) { 'development' }

      it 'returns the dev trade tariff url' do
        expect(helper.trade_tariff_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/sections',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to staging' do
      let(:environment) { 'staging' }

      it 'returns the staging trade tariff url' do
        expect(helper.trade_tariff_url).to eq(
          'https://staging.trade-tariff.service.gov.uk/sections',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to production' do
      let(:environment) { 'production' }

      it 'returns the production trade tariff url' do
        expect(helper.trade_tariff_url).to eq(
          'https://www.trade-tariff.service.gov.uk/sections',
        )
      end
    end
  end

  describe 'a_to_z_url' do
    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to development' do
      let(:environment) { 'development' }

      it 'returns the dev trade tariff a to z url' do
        expect(helper.a_to_z_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/a-z-index/a',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to staging' do
      let(:environment) { 'staging' }

      it 'returns the staging trade tariff a to z url' do
        expect(helper.a_to_z_url).to eq(
          'https://staging.trade-tariff.service.gov.uk/a-z-index/a',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to production' do
      let(:environment) { 'production' }

      it 'returns the production trade tariff a to z url' do
        expect(helper.a_to_z_url).to eq(
          'https://www.trade-tariff.service.gov.uk/a-z-index/a',
        )
      end
    end
  end

  describe 'tools_url' do
    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to development' do
      let(:environment) { 'development' }

      it 'returns the dev trade tariff tools url' do
        expect(helper.tools_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/tools',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to staging' do
      let(:environment) { 'staging' }

      it 'returns the staging trade tariff tools url' do
        expect(helper.tools_url).to eq(
          'https://staging.trade-tariff.service.gov.uk/tools',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_ORIGIN is set to production' do
      let(:environment) { 'production' }

      it 'returns the production trade tariff tools url' do
        expect(helper.tools_url).to eq(
          'https://www.trade-tariff.service.gov.uk/tools',
        )
      end
    end
  end
end
