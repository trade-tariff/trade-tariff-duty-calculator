RSpec.describe ExpressionEvaluators::MeasureUnit do
  subject(:evaluator) do
    described_class.new(measure, user_session)
  end

  let(:measure) do
    Api::Measure.new(
      'id' => 2_046_828,
      'duty_expression' => {
        'base' => '35.10 EUR / 100 kg',
        'formatted_base' => "<span>35.10</span> EUR / <abbr title='Hectokilogram'>100 kg</abbr>",
      },
      'measure_type' => {
        'description' => 'Third country duty',
        'national' => nil,
        'measure_type_series_id' => 'C',
        'id' => '103',
      },
      'measure_conditions' => [],
      'measure_components' => [
        {
          'duty_expression_id' => '01',
          'duty_amount' => 35.1,
          'monetary_unit_code' => 'EUR',
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => 'DTN',
          'duty_expression_description' => '% or amount',
          'duty_expression_abbreviation' => '%',
          'measurement_unit_qualifier_code' => nil,
        },
      ],
    )
  end

  let(:expected_evaluation) do
    {
      calculation: '35.10 EUR / 100 kg * 120.0',
      value: 3596.12136,
      formatted_value: '£3,596.12',
      total_quantity: 120.0,
      unit: 'x 100 kg',
    }
  end

  let(:session_attributes) do
    {
      'import_date' => '2022-01-01',
      'customs_value' => {
        'insurance_cost' => '10',
        'monetary_value' => '10',
        'shipping_cost' => '10',
      },
      'measure_amount' => {
        'dtn' => '120',
      },
      'commodity_source' => 'xi',
      'commodity_code' => '0103921100',
    }
  end

  let(:user_session) { build(:user_session, session_attributes) }

  it 'returns a properly calculated evaluation' do
    expect(evaluator.call).to eq(expected_evaluation)
  end
end
