RSpec.describe Api::Measure, :user_session do
  subject(:measure) do
    described_class.new(
      'id' => 2_046_828,
      'meta' => {
        'duty_calculator' => {
          'source' => 'uk',
        },
      },
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

  let(:user_session) { build(:user_session, :with_document_codes) }

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
                                                    reduction_indicator: 1,
                                                    national_measurement_units: [],
                                                    excluded_countries: [],
                                                    footnotes: []

  describe '#evaluator' do
    context 'when an ad_valorem measure' do
      let(:commodity_code) { '0702000007' }

      it 'calls the correct evaluator' do
        allow(ExpressionEvaluators::AdValorem).to receive(:new)

        measure.evaluator

        expect(ExpressionEvaluators::AdValorem).to have_received(:new).with(measure, measure.component)
      end
    end

    context 'when a specific duty' do
      subject(:measure) do
        described_class.new(
          'id' => 2_046_828,
          'meta' => {
            'duty_calculator' => {
              'source' => 'uk',
            },
          },
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

      it 'calls the correct evaluator' do
        allow(ExpressionEvaluators::MeasureUnit).to receive(:new)

        measure.evaluator

        expect(ExpressionEvaluators::MeasureUnit).to have_received(:new).with(measure, measure.component)
      end
    end

    context 'when a compound duty' do
      subject(:measure) do
        described_class.new(
          'id' => 2_046_828,
          'meta' => {
            'duty_calculator' => {
              'source' => 'uk',
            },
          },
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

      it 'calls the correct evaluator' do
        allow(ExpressionEvaluators::Compound).to receive(:new)

        measure.evaluator

        expect(ExpressionEvaluators::Compound).to have_received(:new).with(measure, nil)
      end
    end
  end

  describe '#evaluator_for_compound_component' do
    subject(:measure) { described_class.new({}) }

    let(:component) { instance_double('Api::MeasureComponent') }
    let(:ad_valorem) { false }
    let(:specific_duty) { false }

    before do
      allow(component).to receive(:ad_valorem?).and_return(ad_valorem)
      allow(component).to receive(:specific_duty?).and_return(specific_duty)
    end

    context 'when an ad_valorem component' do
      let(:ad_valorem) { true }

      it 'instantiates the correct evaluator' do
        allow(ExpressionEvaluators::AdValorem).to receive(:new)

        measure.evaluator_for_compound_component(component)

        expect(ExpressionEvaluators::AdValorem).to have_received(:new).with(measure, component)
      end
    end

    context 'when a specific duty component' do
      let(:specific_duty) { true }

      it 'instantiates the correct evaluator' do
        allow(ExpressionEvaluators::MeasureUnit).to receive(:new)

        measure.evaluator_for_compound_component(component)

        expect(ExpressionEvaluators::MeasureUnit).to have_received(:new).with(measure, component)
      end
    end
  end

  describe '#component' do
    subject(:measure) do
      described_class.new(
        'id' => 2_046_828,
        'meta' => {
          'duty_calculator' => {
            'source' => 'uk',
          },
        },
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

  describe '#all_duties_zero?' do
    subject(:measure) do
      described_class.new(
        'id' => 2_046_828,
        'meta' => {
          'duty_calculator' => {
            'source' => 'uk',
          },
        },
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
        'vat' => vat,
        'measure_conditions' => [],
        'measure_components' => [
          {
            'duty_expression_id' => '01',
            'duty_amount' => duty_amount,
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

    let(:duty_amount) { 35 }
    let(:vat) { false }

    context 'when the measure is VAT' do
      let(:vat) { true }

      it 'returns false' do
        expect(measure.all_duties_zero?).to be false
      end
    end

    it 'returns false' do
      expect(measure.all_duties_zero?).to be false
    end

    context 'when duty amount on the measure is 0' do
      let(:duty_amount) { 0 }

      it 'returns true' do
        expect(measure.all_duties_zero?).to be true
      end
    end
  end

  describe '#vat_type' do
    subject(:measure) do
      described_class.new(
        'id' => 2_046_828,
        'measure_type' => {
          'description' => 'Third country duty',
          'national' => nil,
          'measure_type_series_id' => 'C',
          'id' => '103',
        },
        'vat' => vat,
        'measure_conditions' => [],
        'additional_code' => additional_code,
      )
    end

    let(:vat) { true }
    let(:additional_code) do
      {
        'code' => 'foo',
        'description' => 'COFCO International Argentina S.A.',
        'formatted_description' => 'COFCO International Argentina S.A.',
      }
    end

    context 'when the measure is not VAT' do
      let(:vat) { false }

      it 'returns nil' do
        expect(measure.vat_type).to be nil
      end
    end

    context 'when the measure is VAT' do
      context 'when there is no additional code' do
        let(:additional_code) { {} }

        it 'returns VAT' do
          expect(measure.vat_type).to eq('VAT')
        end
      end

      it 'returns foo' do
        expect(measure.vat_type).to eq('foo')
      end
    end
  end

  describe '#all_components' do
    subject(:measure) do
      described_class.new(
        'id' => 20_121_795,
        'meta' => { 'duty_calculator' => { 'source' => 'uk' } },
        'measure_type' => { 'id' => '117' },
        'measure_conditions' => measure_conditions,
        'measure_components' => measure_components,
      )
    end

    context 'when there are only measure components' do
      let(:measure_components) do
        [
          {
            'duty_expression_id' => '01',
            'duty_amount' => 0.0,
            'monetary_unit_code' => nil,
            'monetary_unit_abbreviation' => nil,
            'measurement_unit_code' => nil,
            'duty_expression_description' => '% or amount',
            'duty_expression_abbreviation' => '%',
            'measurement_unit_qualifier_code' => nil,
            'meta' => nil,
          },
        ]
      end

      let(:measure_conditions) { [] }

      it 'returns the correct components' do
        expect(measure.all_components.as_json).to eq(measure.measure_components.as_json)
      end
    end

    context 'when there are measure conditions with a matching document answer' do
      let(:user_session) do
        build(:user_session, document_code: { 'uk' => { '117' => 'C990' } })
      end

      let(:matching_condition) do
        {
          'action' => 'Apply the mentioned duty',
          'action_code' => '27',
          'certificate_description' => 'End use authorisation ships and platforms (Column 8c, Annex A of Delegated Regulation (EU) 2015/2446)',
          'condition' => 'B: Presentation of a certificate/licence/document',
          'condition_code' => 'B',
          'condition_duty_amount' => nil,
          'condition_measurement_unit_code' => nil,
          'condition_measurement_unit_qualifier_code' => nil,
          'condition_monetary_unit_code' => nil,
          'document_code' => 'C990',
          'duty_expression' => '',
          'monetary_unit_abbreviation' => nil,
          'requirement' => 'Other certificates: End use authorisation ships and platforms (Column 8c, Annex A of Delegated Regulation (EU) 2015/2446)',
          'measure_condition_components' => measure_condition_components,
          'meta' => nil,
        }
      end

      let(:unmatching_condition) do
        {
          'action' => 'Measure not applicable',
          'action_code' => '07',
          'certificate_description' => nil,
          'condition' => 'B: Presentation of a certificate/licence/document',
          'condition_code' => 'B',
          'condition_duty_amount' => nil,
          'condition_measurement_unit_code' => nil,
          'condition_measurement_unit_qualifier_code' => nil,
          'condition_monetary_unit_code' => nil,
          'document_code' => '',
          'duty_expression' => '',
          'monetary_unit_abbreviation' => nil,
          'requirement' => nil,
          'measure_condition_components' => [],
          'meta' => nil,
        }
      end

      let(:measure_components) do
        [
          {
            'duty_expression_id' => '01',
            'duty_amount' => 0.0,
            'monetary_unit_code' => nil,
            'monetary_unit_abbreviation' => nil,
            'measurement_unit_code' => nil,
            'duty_expression_description' => '% or amount',
            'duty_expression_abbreviation' => '%',
            'measurement_unit_qualifier_code' => nil,
            'meta' => nil,
          },
        ]
      end

      let(:measure_conditions) { [unmatching_condition, matching_condition] }

      context 'when the component we apply is in the measure components' do
        let(:measure_condition_components) { [] }

        it 'returns the correct components' do
          expect(measure.all_components.as_json).to eq(measure.measure_components.as_json)
        end
      end

      context 'when the component we apply is in the measure condition components' do
        let(:measure_condition_components) do
          [
            {
              'id' => '20121795-01',
              'duty_expression_id' => '01',
              'duty_amount' => 10.0,
              'monetary_unit_code' => nil,
              'monetary_unit_abbreviation' => nil,
              'measurement_unit_code' => nil,
              'measurement_unit_qualifier_code' => nil,
              'meta' => nil,
            },
          ]
        end

        it 'returns the correct components' do
          expect(measure.all_components.as_json).to eq(
            [
              {
                'attributes' => {
                  'duty_amount' => 10.0,
                  'duty_expression_abbreviation' => nil,
                  'duty_expression_description' => nil,
                  'duty_expression_id' => '01',
                  'id' => '20121795-01',
                  'measurement_unit_code' => nil,
                  'measurement_unit_qualifier_code' => nil,
                  'meta' => nil,
                  'monetary_unit_abbreviation' => nil,
                  'monetary_unit_code' => nil,
                },
              },
            ],
          )
        end
      end
    end
  end
end
