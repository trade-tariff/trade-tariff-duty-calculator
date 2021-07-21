RSpec.describe Steps::DutyController, :user_session do
  before do
    allow(DutyCalculator).to receive(:new).and_return(duty_calculator)
  end

  let(:user_session) { build(:user_session, :with_commodity_information) }
  let(:duty_calculator) { instance_double('DutyCalculator', options: []) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct duty options' do
      response
      expect(assigns[:duty_options]).to eq([])
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('steps/duty/show') }

    it 'calls the DutyCalculator' do
      response
      expect(DutyCalculator).to have_received(:new)
    end

    context 'when on ROW to NI' do
      let(:user_session) { build(:user_session, :with_commodity_information, :deltas_applicable) }
      let(:row_to_ni_duty_calculator) { instance_double('RowToNiDutyCalculator', options: []) }

      it 'calls the RowToNiDutyCalculator' do
        allow(RowToNiDutyCalculator).to receive(:new).and_return(row_to_ni_duty_calculator)

        response

        expect(RowToNiDutyCalculator).to have_received(:new)
      end
    end
  end
end
