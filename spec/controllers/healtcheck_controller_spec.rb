RSpec.describe HealthcheckController do
  describe 'GET #ping' do
    subject(:response) { get :ping }

    it { expect(response.body).to eq('PONG') }
    it { expect(response).to have_http_status(:ok) }
  end
end
