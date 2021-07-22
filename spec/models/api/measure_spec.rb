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
                                                    reduction_indicator: 1,
                                                    national_measurement_units: [],
                                                    excluded_countries: [],
                                                    footnotes: []

  describe '#evaluator' do
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

        measure.evaluator

        expect(ExpressionEvaluators::AdValorem).to have_received(:new).with(measure, measure.component)
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

        measure.evaluator

        expect(ExpressionEvaluators::MeasureUnit).to have_received(:new).with(measure, measure.component)
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
    let(:session_attributes) { {} }

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
end
