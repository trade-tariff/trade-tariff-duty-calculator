RSpec.describe Wizard::Steps::CertificateOfOriginController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Wizard::Steps::CertificateOfOrigin)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('certificate_of_origin/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: answers }

    let(:answers) do
      {
        wizard_steps_certificate_of_origin: {
          certificate_of_origin: certificate_of_origin,
        },
      }
    end

    context 'when the step answers are valid' do
      let(:certificate_of_origin) { 'yes' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::CertificateOfOrigin)
      end

      it { expect(response).to redirect_to(duty_path) }
      it { expect { response }.to change(session, :certificate_of_origin).from(nil).to('yes') }
    end

    context 'when the step answers are invalid' do
      let(:certificate_of_origin) { '' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::CertificateOfOrigin)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('certificate_of_origin/show') }
      it { expect { response }.not_to change(session, :certificate_of_origin).from(nil) }
    end
  end
end
