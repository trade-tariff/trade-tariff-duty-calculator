RSpec.describe ExpressionEvaluators::MeasureUnit, :user_session do
  subject(:evaluator) { described_class.new(measure, component) }

  include_context 'with a fake commodity'

  let(:measure) { commodity.import_measures.first }

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_customs_value,
      :with_measure_amount,
      commodity_code: '0103921100',
    )
  end

  context 'when passing a measure component with a multiplier' do
    let(:commodity) { build(:commodity, :with_measure_units_with_multiplier) }
    let(:component) { measure.measure_components.first }

    let(:expected_evaluation) do
      {
        calculation: '<span>35.10</span> GBP / <abbr title="Hectokilogram">100 kg</abbr> * 1.00',
        formatted_value: '£35.10',
        total_quantity: 1.0,
        unit: 'kilogrammes',
        value: 35.1,
      }
    end

    it 'returns the evaluation with the multiplier applied' do
      expect(evaluator.call).to eq(expected_evaluation)
    end

    it_behaves_like 'an evaluation that uses the measure unit merger'
  end

  context 'when passing a measure component that is in euros' do
    let(:commodity) { build(:commodity, :with_euro_measure_unit_measure_component) }
    let(:component) { measure.measure_components.first }

    let(:expected_evaluation) do
      {
        calculation: '<span>35.10</span> EUR / <abbr title="Hectokilogram">100 kg</abbr> * 100.00',
        formatted_value: '£3,008.42',
        unit: 'x 100 kg',
        total_quantity: 100.0,
        value: 3008.421,
      }
    end

    it { expect(evaluator.call).to eq(expected_evaluation) }

    it_behaves_like 'an evaluation that uses the measure unit merger'
  end

  context 'when passing a measure component that is in pounds' do
    let(:commodity) { build(:commodity, :with_pounds_measure_unit_measure_component) }
    let(:component) { measure.measure_components.first }

    let(:expected_evaluation) do
      {
        calculation: '<span>35.10</span> GBP / <abbr title="Hectokilogram">100 kg</abbr> * 100.00',
        value: 3510.0,
        formatted_value: '£3,510.00',
        unit: 'x 100 kg',
        total_quantity: 100.0,
      }
    end

    it { expect(evaluator.call).to eq(expected_evaluation) }

    it_behaves_like 'an evaluation that uses the measure unit merger'
  end

  context 'when passing a measure condition component' do
    let(:commodity) { build(:commodity, :with_condition_measure_units) }
    let(:component) { measure.measure_conditions.first.measure_condition_components.first }

    let(:expected_evaluation) do
      {
        calculation: '<span>35.10</span> GBP / <abbr title="Hectokilogram">100 kg</abbr> * 100.00',
        value: 3510.0,
        formatted_value: '£3,510.00',
        unit: 'x 100 kg',
        total_quantity: 100.0,
      }
    end

    it { expect(evaluator.call).to eq(expected_evaluation) }

    it_behaves_like 'an evaluation that uses the measure unit merger'
  end
end
