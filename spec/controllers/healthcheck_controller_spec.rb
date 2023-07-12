RSpec.describe HealthcheckController, type: :controller do
  describe 'GET #healthcheck' do
    subject(:response) { get :healthcheck }
    it { expect(response.body).to eq('{"git_sha1":"test"}') }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'GET #checkz' do
    subject(:response) { get :checkz }
    it { expect(response).to have_http_status(:ok) }
  end
end
