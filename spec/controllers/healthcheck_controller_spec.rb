RSpec.describe HealthcheckController do
  describe 'GET #healthcheck' do
    subject(:response) { get :healthcheck }

    it { expect(response.body).to eq('{"git_sha1":"test"}') }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'GET #healthcheckz' do
    subject(:response) { get :healthcheckz }

    it { expect(response.body).to eq('{"git_sha1":"test"}') }
    it { expect(response).to have_http_status(:ok) }
  end
end
