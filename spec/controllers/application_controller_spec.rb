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

  describe '#title' do
    before do
      allow(controller.helpers).to receive(:referred_service).and_return(service)
    end

    context 'when the service is uk' do
      let(:service) { :uk }

      it { expect(controller.helpers.title).to eq('UK Integrated Online Tariff') }
    end

    context 'when the service is xi' do
      let(:service) { :xi }

      it { expect(controller.helpers.title).to eq('Northern Ireland Online Tariff') }
    end
  end
end
