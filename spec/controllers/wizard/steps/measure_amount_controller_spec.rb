RSpec.describe Wizard::Steps::MeasureAmountController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Wizard::Steps::MeasureAmount)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('measure_amount/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: answers }

    let(:answers) do
      {
        wizard_steps_measure_amount: measure_amount,
      }
    end

    context 'when the step answers are valid' do
      let(:measure_amount) do
        {
          'dtn' => 100,
        }
      end

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::MeasureAmount)
      end

      it { expect(response).to redirect_to(additional_codes_path('105')) }
      it { expect { response }.to change(session, :measure_amount).from({}).to('dtn' => '100') }
    end

    context 'when the step answers are invalid' do
      let(:measure_amount) { attributes_for(:measure_amount, measure_amount: '') }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::MeasureAmount)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('measure_amount/show') }
      it { expect { response }.not_to change(session, :measure_amount).from({}) }
    end
  end
end
