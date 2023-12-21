RSpec.describe ErrorsController, type: :request do
  include ApplicationHelper

  subject(:rendered) { make_request && response }

  let(:json_response) { JSON.parse(rendered.body) }
  let(:body) { rendered.body }

  shared_examples 'a json error response' do |status_code, message|
    it { is_expected.to have_http_status status_code }
    it { is_expected.to have_attributes media_type: 'application/json' }
    it { expect(json_response).to include 'error' => message }
  end

  # Tests Json error responses

  describe 'GET /400.json' do
    let(:make_request) { get '/400.json' }

    it_behaves_like 'a json error response', 400, 'Bad request'
  end

  describe 'GET /404.json' do
    let(:make_request) { get '/404.json' }

    it_behaves_like 'a json error response', 404, 'Resource not found'
  end

  describe 'GET /405.json' do
    let(:make_request) { get '/405.json' }

    it_behaves_like 'a json error response', 405, 'Method not allowed'
  end

  describe 'GET /406.json' do
    let(:make_request) { get '/406.json' }

    it_behaves_like 'a json error response', 406, 'Not acceptable'
  end

  describe 'GET /422.json' do
    let(:make_request) { get '/422.json' }

    it_behaves_like 'a json error response', 422, 'Unprocessable entity'
  end

  describe 'GET /500.json' do
    let(:make_request) { get '/500.json' }

    it_behaves_like 'a json error response', 500, 'Internal server error'
  end

  describe 'GET /501.json' do
    let(:make_request) { get '/501.json' }

    it_behaves_like 'a json error response', 501, 'Not implemented'
  end

  # Test html error responses

  describe 'GET /400' do
    let(:make_request) { get '/400' }

    it { expect(body).to include 'Bad request' }
  end

  describe 'GET /404' do
    let(:make_request) { get '/404' }

    it { expect(body).to include 'The page you were looking for does not exist.' }
  end

  describe 'GET /406' do
    let(:make_request) { get '/406' }

    it { expect(body).to include 'Not acceptable' }
  end

  describe 'GET /422' do
    let(:make_request) { get '/422' }

    it { expect(body).to include 'The change you wanted was rejected.' }
  end

  describe 'GET /500' do
    let(:make_request) { get '/500' }

    it { expect(body).to include 'Sorry, there is a problem with the service' }
  end

  describe 'GET #501' do
    let(:make_request) { get '/501' }

    it { expect(body).to include 'Not implemented' }
  end
end
