RSpec.describe Wizard::Steps::VatController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Wizard::Steps::Vat)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('vat/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: answers }

    let(:answers) do
      {
        wizard_steps_vat: vat,
      }
    end

    context 'when the step answers are valid' do
      let(:vat) { attributes_for(:vat, vat: 'VATE') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::Vat)
      end

      it { expect(response).to redirect_to(confirm_path) }
      it { expect { response }.to change(session, :vat).from(nil).to('VATE') }
    end

    context 'when the step answers are invalid' do
      let(:vat) { attributes_for(:vat, vat: '') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::Vat)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('vat/show') }
      it { expect { response }.not_to change(session, :vat).from(nil) }
    end
  end
end
