RSpec.describe Wizard::Steps::BaseController do
  controller do
    def index
      render plain: 'Hari Seldon'
    end

    def create
      render plain: 'Hari Seldon'

      raise ArgumentError, 'This is a test'
    end
  end

  let(:user_session) { build(:user_session, commodity_code: '0702000007', commodity_source: 'uk', referred_service: 'uk', session_id: 'foo') }

  let(:expected_tracked_attributes) do
    {
      session: user_session.session,
      commodity_code: '0702000007',
      commodity_source: 'uk',
      referred_service: 'uk',
    }
  end

  before do
    allow(UserSession).to receive(:new).and_return(user_session)
    allow(NewRelic::Agent).to receive(:add_custom_attributes).and_call_original
    allow(Raven).to receive(:user_context)
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
  end

  describe 'GET #error' do
    subject(:response) { get :create }

    it 'adds session context for the user on error' do
      response
    rescue ArgumentError
      expect(Raven).to have_received(:user_context).with(user_session.session.to_h.except('_csrf_token'))
    end

    it 'sends custom attributes to NewRelic' do
      response
    rescue ArgumentError
      expect(NewRelic::Agent).to have_received(:add_custom_attributes).with(expected_tracked_attributes)
    end
  end
end
