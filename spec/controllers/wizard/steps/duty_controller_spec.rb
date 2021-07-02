RSpec.describe Wizard::Steps::DutyController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
    allow(DutyCalculator).to receive(:new).and_return(duty_calculator)
    allow(Api::ExchangeRate).to receive(:for).with('GBP').and_call_original
  end

  let(:session) { build(:user_session, :with_commodity_information) }
  let(:duty_calculator) { instance_double('DutyCalculator', options: []) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct duty options' do
      response
      expect(assigns[:duty_options]).to eq([])
    end

    it 'assigns the correct exchange rate options' do
      response
      expect(assigns[:gbp_to_eur_exchange_rate]).to eq(0.8538)
    end

    it 'calls the ExchangeRate api' do
      response
      expect(Api::ExchangeRate).to have_received(:for)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('wizard/steps/duty/show') }

    it 'calls the DutyCalculator' do
      response
      expect(DutyCalculator).to have_received(:new)
    end

    context 'when on ROW to NI' do
      let(:session) { build(:user_session, :with_commodity_information, :deltas_applicable) }
      let(:row_to_ni_duty_calculator) { instance_double('RowToNiDutyCalculator', options: []) }

      it 'calls the RowToNiDutyCalculator' do
        allow(RowToNiDutyCalculator).to receive(:new).and_return(row_to_ni_duty_calculator)

        response

        expect(RowToNiDutyCalculator).to have_received(:new)
      end
    end
  end
end
