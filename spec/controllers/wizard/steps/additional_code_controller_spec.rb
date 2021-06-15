RSpec.describe Wizard::Steps::AdditionalCodesController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show, params: { measure_type_id: '105' } }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Wizard::Steps::AdditionalCode)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('additional_codes/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: { measure_type_id: '105' }.merge(answers) }

    let(:answers) do
      {
        wizard_steps_additional_code: {
          additional_code: additional_code,
        },
      }
    end

    context 'when the step answers are valid' do
      let(:additional_code) { '2600' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::AdditionalCode)
      end

      it { expect(response).to redirect_to(vat_path) }
      it { expect { response }.to change(session, :additional_code).from({}).to('105' => '2600') }
    end

    context 'when the step answers are invalid' do
      let(:additional_code) { '' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::AdditionalCode)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('additional_codes/show') }
      it { expect { response }.not_to change(session, :additional_code).from({}) }
    end
  end
end
