RSpec.describe Steps::ExciseController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show, params: { measure_type_id: '306' } }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Steps::Excise)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('excise/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: { measure_type_id: '306' }.merge(answers) }

    let(:answers) do
      {
        steps_excise: {
          additional_code: additional_code,
        },
      }
    end

    context 'when the step answers are valid' do
      let(:additional_code) { 'X444' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::Excise)
      end

      xit { expect(response).to redirect_to(vat_path) }
      it { expect { response }.to change(session, :excise_additional_code).from({}).to('306' => 'X444') }
    end

    context 'when the step answers are invalid' do
      let(:additional_code) { '' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::Excise)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('excise/show') }
      it { expect { response }.not_to change(session, :excise_additional_code).from({}) }
    end
  end
end
