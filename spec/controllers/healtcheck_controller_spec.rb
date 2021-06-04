RSpec.describe HealthcheckController do
  describe 'GET #ping' do
    subject(:response) { get :ping }

    it { expect(response.body).to eq('PONG') }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'GET #healthcheck' do
    subject(:response) { get :healthcheck }

    it { expect(response.body).to eq('{"git_sha1":"test"}') }
    it { expect(response).to have_http_status(:ok) }
  end
end
