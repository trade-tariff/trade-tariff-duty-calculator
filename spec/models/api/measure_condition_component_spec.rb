RSpec.describe Api::MeasureConditionComponent do
  subject(:component) { build(:measure_condition_component) }

  it { is_expected.to be_a(Api::BaseComponent) }
  it { is_expected.to be_belongs_to_measure_condition }

  describe '#measure_condition_sid' do
    subject(:component) { build(:measure_condition_component, id: '12345-01') }

    it { expect(component.measure_condition_sid).to eq('12345') }
  end
end
