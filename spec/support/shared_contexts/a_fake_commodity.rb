RSpec.shared_context 'with a fake commodity' do
  before do
    Thread.current[:commodity_context_service] = instance_double('CommodityContextService', call: commodity)
  end
end
