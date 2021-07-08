RSpec.describe Steps::ImportDateController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_country_of_origin) }
  let(:commodity_code) { '01234567890' }
  let(:referred_service) { 'uk' }

  describe 'GET #show' do
    subject(:response) { get :show, params: { commodity_code: commodity_code, referred_service: referred_service } }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Steps::ImportDate)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('import_date/show') }
    it { expect { response }.to change(session, :commodity_code).from(nil).to(commodity_code) }
    it { expect { response }.to change(session, :commodity_source).from(nil).to(referred_service) }
    it { expect { response }.to change(session, :referred_service).from(nil).to(referred_service) }
    it { expect { response }.to change(session, :country_of_origin).from('GB').to(nil) }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: { commodity_code: commodity_code, referred_service: referred_service }.merge(answers) }

    let(:answers) do
      {
        steps_import_date: {
          'import_date(3i)': day,
          'import_date(2i)': month,
          'import_date(1i)': year,
        },
      }
    end

    let(:now) { Date.current }

    context 'when the step answers are valid' do
      let(:year) { now.year }
      let(:month) { now.month }
      let(:day) { now.day }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::ImportDate)
      end

      it { expect(response).to redirect_to(import_destination_path) }
      it { expect { response }.to change(session, :import_date).from(nil).to(now) }
    end

    context 'when the step answers are invalid' do
      let(:year) { now.year }
      let(:month) { '' }
      let(:day) { '' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Steps::ImportDate)
      end

      it { is_expected.to have_http_status(:ok) }
      it { expect { response }.not_to change(session, :import_date).from(nil) }
    end
  end
end
