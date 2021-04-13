RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'Hari Seldon'
    end
  end

  before do
    get :index
  end

  it 'has the correct Cache-Control header' do
    get :index

    expect(response.headers['Cache-Control']).to eq('max-age=0, private, stale-while-revalidate=0, stale-if-error=0')
  end
end
