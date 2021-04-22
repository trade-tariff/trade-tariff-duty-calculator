RSpec.describe ExpressionEvaluators::Compound do
  subject(:evaluator) do
    described_class.new(measure, user_session)
  end

  let(:measure) do
    Api::Measure.new(
      'id' => 3_211_138,
      'duty_expression' => {
        'base' => 'foo',
        'formatted_base' => 'foo',
      },
      'measure_components' => [
        {
          'duty_expression_id' => '01',
          'duty_amount' => 13.8,
          'monetary_unit_code' => nil,
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => nil,
          'duty_expression_description' => '% or amount',
          'duty_expression_abbreviation' => '%',
          'measurement_unit_qualifier_code' => nil,
        },
        {
          'duty_expression_id' => '15',
          'duty_amount' => 13.0,
          'monetary_unit_code' => 'GBP',
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => 'DTN',
          'duty_expression_description' => 'Minimum',
          'duty_expression_abbreviation' => 'MIN',
          'measurement_unit_qualifier_code' => nil,
        },
        {
          'duty_expression_id' => '17',
          'duty_amount' => 15.0,
          'monetary_unit_code' => 'GBP',
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => 'DTN',
          'duty_expression_description' => 'Maximum',
          'duty_expression_abbreviation' => 'MAX',
          'measurement_unit_qualifier_code' => nil,
        },
        {
          'duty_expression_id' => '36',
          'duty_amount' => 7.0,
          'monetary_unit_code' => 'GBP',
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => 'DTN',
          'duty_expression_description' => '-',
          'duty_expression_abbreviation' => '-',
          'measurement_unit_qualifier_code' => nil,
        },
      ],
    )
  end

  let(:expected_evaluation) do
    {
      value: 8.0,
      formatted_value: '£8.00',
      calculation: 'foo',
    }
  end

  let(:session_attributes) do
    {
      'import_date' => '2022-01-01',
      'customs_value' => {
        'insurance_cost' => '1000',
        'monetary_value' => '',
        'shipping_cost' => '',
      },
      'measure_amount' => {
        'dtn' => '1',
      },
      'commodity_source' => 'xi',
      'commodity_code' => '0102291010',
    }
  end

  let(:user_session) { build(:user_session, session_attributes) }

  it 'returns a properly calculated evaluation' do
    expect(evaluator.call).to eq(expected_evaluation)
  end
end
