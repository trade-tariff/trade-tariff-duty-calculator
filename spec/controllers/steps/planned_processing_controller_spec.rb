RSpec.describe Steps::PlannedProcessingController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Steps::PlannedProcessing)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('planned_processing/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: answers }

    let(:answers) do
      {
        steps_planned_processing: planned_processing,
      }
    end

    context 'when the step answers are valid' do
      let(:planned_processing) { attributes_for(:planned_processing, planned_processing: 'commercial_purposes') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::PlannedProcessing)
      end

      it { expect(response).to redirect_to(interstitial_path) }
      it { expect { response }.to change(session, :planned_processing).from(nil).to('commercial_purposes') }
    end

    context 'when the step answers are invalid' do
      let(:planned_processing) { attributes_for(:planned_processing, planned_processing: '') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::PlannedProcessing)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('planned_processing/show') }
      it { expect { response }.not_to change(session, :planned_processing).from(nil) }
    end
  end
end
