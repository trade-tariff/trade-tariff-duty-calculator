RSpec.describe Api::MeasureConditionComponent do
  subject(:component) { build(:measure_condition_component) }

  it { is_expected.to be_a(Api::BaseComponent) }
  it { is_expected.to be_belongs_to_measure_condition }

  describe '#measure_condition_sid' do
    subject(:component) { build(:measure_condition_component, id:).measure_condition_sid }

    context 'when the measure condition sid is a negative number' do
      let(:id) { '-12345-1' }

      it { is_expected.to eq('-12345') }
    end

    context 'when the measure condition sid is a positive number' do
      let(:id) { '12345-1' }

      it { is_expected.to eq('12345') }
    end
  end
end
