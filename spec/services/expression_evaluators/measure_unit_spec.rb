RSpec.describe ExpressionEvaluators::MeasureUnit, :user_session do
  subject(:evaluator) do
    described_class.new(measure, component)
  end

  before do
    allow(ApplicableMeasureUnitMerger).to receive(:new).and_call_original
  end

  let(:measure) do
    build(
      :measure,
      :third_country_tariff,
      id: 2_046_828,
      measure_components: [measure_component],
      measure_conditions: [measure_condition],
      duty_expression: {
        base: '35.10 EUR / 100 kg',
        formatted_base: "<span>35.10</span> EUR / <abbr title='Hectokilogram'>100 kg</abbr>",
      },
    )
  end

  let(:measure_component) { nil }
  let(:measure_condition) { nil }

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_customs_value,
      :with_measure_amount,
      commodity_code: '0103921100',
    )
  end

  context "when passing a measure's component" do
    let(:component) { measure.measure_components.first }

    let(:measure_component) { attributes_for(:measure_component, :with_measure_units) }

    let(:expected_evaluation) do
      {
        calculation: '<span>35.10</span> EUR / <abbr title="Hectokilogram">100 kg</abbr> * 100.00',
        value: 3510.0,
        formatted_value: '£3,510.00',
        unit: 'x 100 kg',
        total_quantity: 100.0,
      }
    end

    it { expect(evaluator.call).to eq(expected_evaluation) }

    it 'calls the ApplicableMeasureUnitMerger service to merge units' do
      evaluator.call

      expect(ApplicableMeasureUnitMerger).to have_received(:new)
    end
  end

  context "when passing a measure condition's component" do
    let(:component) do
      measure.measure_conditions.first.measure_condition_components.first
    end

    let(:measure_condition) do
      attributes_for(
        :measure_condition,
        :with_trigger_measure_units,
        measure_condition_components: [measure_condition_component],
      )
    end

    let(:measure_condition_component) do
      attributes_for(:measure_condition_component, :with_measure_units)
    end

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

    it 'calls the ApplicableMeasureUnitMerger service to merge units' do
      evaluator.call

      expect(ApplicableMeasureUnitMerger).to have_received(:new)
    end
  end
end
