RSpec.describe Steps::FinalUseController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Steps::FinalUse)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('final_use/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: answers }

    let(:answers) do
      {
        steps_final_use: final_use,
      }
    end

    context 'when the step answers are valid' do
      let(:final_use) { attributes_for(:final_use, final_use: 'no') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::FinalUse)
      end

      it { expect(response).to redirect_to(trade_remedies_path) }
      it { expect { response }.to change(session, :final_use).from(nil).to('no') }
    end

    context 'when the step answers are invalid' do
      let(:final_use) { attributes_for(:final_use, final_use: '') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::FinalUse)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('final_use/show') }
      it { expect { response }.not_to change(session, :final_use).from(nil) }
    end
  end
end
