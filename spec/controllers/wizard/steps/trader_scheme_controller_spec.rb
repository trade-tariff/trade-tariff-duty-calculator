RSpec.describe Wizard::Steps::TraderSchemeController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Wizard::Steps::TraderScheme)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('trader_scheme/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: answers }

    let(:answers) do
      {
        wizard_steps_trader_scheme: trader_scheme,
      }
    end

    context 'when the step answers are valid' do
      let(:trader_scheme) { attributes_for(:trader_scheme, trader_scheme: 'no') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::TraderScheme)
      end

      it { expect(response).to redirect_to(trade_remedies_path) }
      it { expect { response }.to change(session, :trader_scheme).from(nil).to('no') }
    end

    context 'when the step answers are invalid' do
      let(:trader_scheme) { attributes_for(:trader_scheme, trader_scheme: '') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::TraderScheme)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('trader_scheme/show') }
      it { expect { response }.not_to change(session, :trader_scheme).from(nil) }
    end
  end
end
