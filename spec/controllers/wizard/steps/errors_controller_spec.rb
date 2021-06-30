RSpec.describe ErrorsController do
  let(:commodity_code) { '0702000007' }
  let(:referred_service) { 'uk' }

  describe 'GET /404' do
    subject(:response) { get :not_found }

    it { is_expected.to have_http_status(:not_found) }
    it { is_expected.to render_template(:not_found) }
    it { is_expected.to render_template(:application) }
  end

  describe 'GET /422' do
    subject(:response) { get :unprocessable_entity }

    it { is_expected.to have_http_status(:unprocessable_entity) }
    it { is_expected.to render_template(:unprocessable_entity) }
    it { is_expected.to render_template(:application) }
  end

  describe 'GET /500' do
    subject(:response) { get :internal_server_error }

    it { is_expected.to have_http_status(:internal_server_error) }
    it { is_expected.to render_template(:internal_server_error) }
    it { is_expected.to render_template(:application) }
  end
end
