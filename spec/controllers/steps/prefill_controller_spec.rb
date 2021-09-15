RSpec.describe Steps::PrefillController, :user_session do
  let(:user_session) { build(:user_session) }

  describe 'GET #show' do
    subject(:response) { get :show, params: params }

    let(:params) do
      {
        commodity_code: '0702000007',
        country_of_origin: 'FI',
        import_date: '2021-02-17',
        import_destination: 'UK',
        redirect_to: 'http://localhost/flibble',
      }
    end

    before do
      allow(UserSession).to receive(:build_from_params).and_call_original
    end

    it 'builds the session from params' do
      response
      expect(UserSession).to have_received(:build_from_params)
    end

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Steps::Prefill)
    end

    it { expect(response).to redirect_to(trader_scheme_path) }
  end
end
