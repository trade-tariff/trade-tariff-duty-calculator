RSpec.describe Steps::BaseController, :user_session do
  controller do
    def index
      render plain: 'Hari Seldon'
    end

    def create
      render plain: 'Hari Seldon'

      raise ArgumentError, 'This is a test'
    end
  end

  let(:user_session) { build(:user_session, :with_commodity_information, session_id: 'foo') }
  let(:trade_tariff_host) { 'https://dev.trade-tariff.service.gov.uk' }

  let(:expected_tracked_attributes) do
    {
      session: user_session.session,
      commodity_code: '0702000007',
      commodity_source: 'uk',
      referred_service: 'uk',
    }
  end

  before do
    allow(NewRelic::Agent).to receive(:add_custom_attributes).and_call_original
    allow(Sentry).to receive(:set_user)
    allow(Rails.configuration).to receive(:trade_tariff_frontend_url).and_return(trade_tariff_host)
  end

  describe 'GET #index' do
    subject(:response) { get :index }

    it 'sends custom attributes to NewRelic' do
      response
      expect(NewRelic::Agent).to have_received(:add_custom_attributes).with(expected_tracked_attributes)
    end

    it 'initializes the CommodityContextService' do
      response
      expect(Thread.current[:commodity_context_service]).to be_a(CommodityContextService)
    end

    context 'when commodity_code is not set' do
      let(:user_session) { build(:user_session) }

      it { expect(response).not_to redirect_to(trade_tariff_host) }
    end

    context 'when commodity_code is set' do
      let(:user_session) { build(:user_session, :with_commodity_information) }

      it { expect(response).not_to redirect_to(trade_tariff_host) }
    end
  end

  describe 'GET #error' do
    subject(:response) { get :create }

    it 'adds session context for the user on error' do
      response
    rescue ArgumentError
      expect(Sentry).to have_received(:set_user).with(user_session.session.to_h.except('_csrf_token'))
    end

    it 'sends custom attributes to NewRelic' do
      response
    rescue ArgumentError
      expect(NewRelic::Agent).to have_received(:add_custom_attributes).with(expected_tracked_attributes)
    end
  end

  describe '#title' do
    before do
      controller.instance_variable_set('@step', step)
    end

    context 'when the step does not have a translation' do
      let(:step) { Steps::Base.new }

      it { expect(controller.helpers.title).to eq('UK Integrated Online Tariff') }
    end

    context 'when the service is xi' do
      let(:step) { Steps::Vat.new }

      it { expect(controller.helpers.title).to eq('Which VAT rate is applicable to your trade - Online Tariff Duty Calculator') }
    end
  end
end
