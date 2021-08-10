RSpec.describe ExpressionEvaluators::MeasureUnit, :user_session do
  subject(:evaluator) do
    described_class.new(measure, measure.measure_components.first)
  end

  let(:measure) do
    build(
      :measure,
      :third_country_tariff,
      id: 2_046_828,
      measure_components: [measure_component],
      duty_expression: {
        base: '35.10 EUR / 100 kg',
        formatted_base: "<span>35.10</span> EUR / <abbr title='Hectokilogram'>100 kg</abbr>",
      },
    )
  end

  let(:measure_component) do
    attributes_for(:measure_component, :with_measure_units)
  end

  let(:expected_evaluation) do
    {
      calculation: '<span>35.10</span> EUR / <abbr title="Hectokilogram">100 kg</abbr> * 100.00',
      value: 3510.0,
      formatted_value: '£3,510.00',
      unit: 'x 100 kg',
      total_quantity: 100.0,
    }
  end

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_customs_value,
      :with_measure_amount,
      commodity_code: '0103921100',
    )
  end

  it { expect(evaluator.call).to eq(expected_evaluation) }

  context 'when on a route where deltas apply' do
    before do
      allow(MeasureUnitMerger).to receive(:new).and_call_original
    end

    let(:measure_unit_merger) { instance_double('MeasureUnitMerger') }

    let(:user_session) do
      build(
        :user_session,
        :with_commodity_information,
        :with_customs_value,
        :with_measure_amount,
        :deltas_applicable,
        commodity_code: '0103921100',
      )
    end

    it 'calls the MeasureUnitMerger service to merge units' do
      evaluator.call

      expect(MeasureUnitMerger).to have_received(:new)
    end
  end
end
