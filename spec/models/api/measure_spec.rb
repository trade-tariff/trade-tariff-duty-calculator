RSpec.describe Api::Measure do
  subject(:measure) do
    described_class.new(
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
          'duty_amount' => 10.0,
          'monetary_unit_code' => nil,
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => nil,
          'duty_expression_description' => '% or amount',
          'duty_expression_abbreviation' => '%',
          'measurement_unit_qualifier_code' => nil,
        },
      ],
    )
  end

  let(:user_session) do
    build(:user_session, session_attributes)
  end

  let(:commodity_source) { 'XI' }

  it_behaves_like 'a resource that has attributes', measure_conditions: [],
                                                    measure_components: [],
                                                    id: -582_007,
                                                    origin: 'uk',
                                                    effective_start_date: '2020-08-01T00:00:00.000Z',
                                                    effective_end_date: nil,
                                                    import: true,
                                                    excise: false,
                                                    vat: true,
                                                    legal_acts: [],
                                                    national_measurement_units: [],
                                                    excluded_countries: [],
                                                    footnotes: []

  describe '#evaluator_for' do
    context 'when an ad_valorem measure' do
      let(:commodity_code) { '0702000007' }

      let(:session_attributes) do
        {
          'customs_value' => {
            'monetary_value' => '1000',
            'shipping_cost' => '40',
            'insurance_cost' => '10',
          },
          'commodity_source' => commodity_source,
          'commodity_code' => commodity_code,
        }
      end

      it 'calls the correct evaluator' do
        allow(ExpressionEvaluators::AdValorem).to receive(:new)

        measure.evaluator_for(user_session)

        expect(ExpressionEvaluators::AdValorem).to have_received(:new).with(measure, user_session)
      end
    end

    context 'when a specific duty' do
      subject(:measure) do
        described_class.new(
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

      let(:commodity_code) { '0103921100' }

      let(:session_attributes) do
        {
          'customs_value' => {
            'monetary_value' => '1000',
            'shipping_cost' => '40',
            'insurance_cost' => '10',
          },
          'measure_amount' => {
            'dtn' => '120',
          },
          'commodity_source' => commodity_source,
          'commodity_code' => commodity_code,
        }
      end

      it 'calls the correct evaluator' do
        allow(ExpressionEvaluators::MeasureUnit).to receive(:new)

        measure.evaluator_for(user_session)

        expect(ExpressionEvaluators::MeasureUnit).to have_received(:new).with(measure, user_session)
      end
    end

    context 'when a compound duty' do
      subject(:measure) do
        described_class.new(
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
          ],
        )
      end

      let(:commodity_code) { '0103921100' }

      let(:session_attributes) do
        {
          'customs_value' => {
            'monetary_value' => '1000',
            'shipping_cost' => '40',
            'insurance_cost' => '10',
          },
          'measure_amount' => {
            'dtn' => '120',
          },
          'commodity_source' => commodity_source,
          'commodity_code' => commodity_code,
        }
      end

      it 'calls the correct evaluator' do
        allow(ExpressionEvaluators::Compound).to receive(:new)

        measure.evaluator_for(user_session)

        expect(ExpressionEvaluators::Compound).to have_received(:new).with(measure, user_session)
      end
    end
  end

  describe '#component' do
    subject(:measure) do
      described_class.new(
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
          {
            'duty_expression_id' => '02',
            'duty_amount' => 40,
            'monetary_unit_code' => 'EUR',
            'monetary_unit_abbreviation' => nil,
            'measurement_unit_code' => 'DTN',
            'duty_expression_description' => '% or amount',
            'duty_expression_abbreviation' => '%',
            'measurement_unit_qualifier_code' => 'R',
          },
        ],
      )
    end

    it 'returns the correct component' do
      expect(measure.component.duty_expression_id).to eq('01')
    end
  end
end
