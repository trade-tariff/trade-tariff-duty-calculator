RSpec.describe Wizard::Steps::BaseController do
  controller do
    def index
      render plain: 'Hari Seldon'
    end
  end

  subject(:response) { get :index }

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

    response
  end

  it 'sends custom attributes to NewRelic' do
    expect(NewRelic::Agent).to have_received(:add_custom_attributes).with(expected_tracked_attributes)
  end
end
