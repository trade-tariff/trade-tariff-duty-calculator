RSpec.describe Wizard::Steps::CountryOfOriginController do
  before do
    allow(UserSession).to receive(:new).and_return(session)
  end

  let(:session) { build(:user_session, :with_commodity_information) }

  describe 'GET #show' do
    subject(:response) { get :show }

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Wizard::Steps::CountryOfOrigin)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('country_of_origin/show') }
  end

  describe 'POST #create' do
    subject(:response) { post :create, params: answers }

    let(:answers) do
      {
        wizard_steps_country_of_origin: {
          country_of_origin: country_of_origin,
          other_country_of_origin: other_country_of_origin,
        },
      }
    end

    context 'when the step answers are valid' do
      let(:country_of_origin) { 'OTHER' }
      let(:other_country_of_origin) { 'RO' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::CountryOfOrigin)
      end

      it { expect(response).to redirect_to(trader_scheme_path) }
      it { expect { response }.to change(session, :country_of_origin).from(nil).to('OTHER') }
      it { expect { response }.to change(session, :other_country_of_origin).from('').to('RO') }
    end

    context 'when the step answers are invalid' do
      let(:country_of_origin) { '' }
      let(:other_country_of_origin) { '' }

      it 'assigns the correct step' do
        response
        expect(assigns[:step]).to be_a(Wizard::Steps::CountryOfOrigin)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('country_of_origin/show') }
      it { expect { response }.not_to change(session, :country_of_origin).from(nil) }
      it { expect { response }.not_to change(session, :other_country_of_origin).from('') }
    end
  end
end
