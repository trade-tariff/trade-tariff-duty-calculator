RSpec.describe 'Session integrity', type: :request do
  context 'when the session expires or is empty for any reason' do
    context 'when deep linking to any question but import_date question' do
      let(:trade_tariff_host) { 'https://dev.trade-tariff.service.gov.uk' }

      it 'redirects to the trade tariff platform ' do
        allow(Rails.configuration).to receive(:trade_tariff_frontend_url).and_return(trade_tariff_host)

        get import_destination_path

        expect(response).to redirect_to('https://dev.trade-tariff.service.gov.uk/sections')
      end
    end

    context 'when landing on import_date question' do
      let(:commodity_code) { '0702000007' }
      let(:referred_service) { 'uk' }
      let(:import_into) { 'UK' }

      it 'does not redirect to the trade tariff platform' do
        get import_date_path(commodity_code: commodity_code, referred_service: referred_service)

        expect(response.body).to include('When will the goods be imported?')
      end
    end
  end
end
