RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'Hari Seldon'
    end
  end

  before do
    get :index
  end

  let(:expected_cache_control) { 'no-cache' }

  it 'has the correct Cache-Control header' do
    expect(response.headers['Cache-Control']).to eq(expected_cache_control)
  end
end
