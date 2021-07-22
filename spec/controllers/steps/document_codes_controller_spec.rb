RSpec.describe Steps::DocumentCodesController, :user_session do
  let(:user_session) { build(:user_session, :with_commodity_information, commodity_code: '7202999000') }

  describe 'GET #show' do
    subject(:response) { get :show, params: { measure_type_id: '105' } }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Steps::DocumentCode)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('document_codes/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: { measure_type_id: '105' }.merge(answers) }

    let(:answers) do
      {
        steps_document_code: {
          document_code_uk: document_code_uk,
          document_code_xi: document_code_xi,
        },
      }
    end

    context 'when the step answers are valid' do
      let(:document_code_uk) { ['C644', 'Y929', ''] }
      let(:document_code_xi) { ['N851', ''] }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::DocumentCode)
      end

      it { expect(response).to redirect_to(document_codes_path('117')) }
      it { expect { response }.to change(user_session, :document_code_uk).from({}).to('105' => ['C644', 'Y929', '']) }
    end
  end
end
