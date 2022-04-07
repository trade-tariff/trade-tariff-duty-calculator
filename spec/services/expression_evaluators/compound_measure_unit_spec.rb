RSpec.describe ExpressionEvaluators::CompoundMeasureUnit, :user_session do
  subject(:evaluator) { described_class.new(measure, measure.component) }

  let(:measure) do
    build(
      :measure,
      :third_country_tariff,
      measure_components:,
      duty_expression: {
        'formatted_base' => "<span>0.50</span> GBP / <abbr title='%vol'>% vol/hl</abbr> + <span>2.60</span> GBP / <abbr title='Hectolitre'>hl</abbr>",
      },
    )
  end

  let(:measure_components) do
    [

      {
        'duty_amount' => 0.5,
        'monetary_unit_code' => 'GBP',
        'measurement_unit_code' => 'ASV',
        'measurement_unit_qualifier_code' => 'X',
      },
    ]
  end

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_customs_value,
      :with_compound_measure_amount,
      commodity_code: '2208403900',
    )
  end

  let(:expected_evaluation) do
    {
      calculation: '<span>0.50</span> GBP / <abbr title="%vol">% vol/hl</abbr> + <span>2.60</span> GBP / <abbr title="Hectolitre">hl</abbr>',
      formatted_value: '£900.00',
      value: 900.0,
    }
  end

  it { expect(evaluator.call).to eq(expected_evaluation) }
end
