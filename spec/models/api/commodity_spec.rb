require 'rails_helper'

RSpec.describe Api::Commodity, type: :model do
  subject(:commodity) { described_class.build(service, commodity_code) }

  let(:commodity_code) { '0702000007' }
  let(:service) { :uk }

  before do
    allow(Uktt::Commodity).to receive(:new).and_call_original
  end

  describe '.resource_key' do
    it 'returns the correct resource key' do
      expect(described_class.resource_key).to eq(:commodity_id)
    end
  end

  describe '#description' do
    it 'returns the expected description' do
      expect(commodity.description).to eq('Cherry Tomatoes')
    end

    it 'returns a safe html description' do
      expect(commodity.description).to be_html_safe
    end
  end

  describe '#code' do
    it 'returns the goods_nomenclature_item_id' do
      expect(commodity.code).to eq(commodity.goods_nomenclature_item_id)
    end
  end

  describe '#import_measures' do
    it 'returns a list of measures' do
      all_are_measures = commodity.import_measures.all? { |resource| resource.is_a?(Api::Measure) }

      expect(all_are_measures).to be(true)
    end
  end

  describe '#export_measures' do
    it 'returns a list of measures' do
      all_are_measures = commodity.export_measures.all? { |resource| resource.is_a?(Api::Measure) }

      expect(all_are_measures).to be(true)
    end
  end
end
