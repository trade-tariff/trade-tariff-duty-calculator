RSpec.describe DutyOptions::ThirdCountryTariff do
  subject(:service) { described_class.new(measure, user_session, additional_duty_rows) }

  describe '#option' do
    let(:commodity_source) { 'XI' }
    let(:commodity_code) { '0702000007' }

    let(:session_attributes) do
      {
        'import_date' => '2022-01-01',
        Wizard::Steps::CustomsValue.id => {
          'monetary_value' => '1000',
          'shipping_cost' => '40',
          'insurance_cost' => '10',
        },
        'commodity_source' => commodity_source,
        'commodity_code' => commodity_code,
      }
    end

    let(:measure) do
      Api::Measure.new(
        measure_type: { id: '103' },
        measure_components: [measure_component],
        measure_conditions: [],
      )
    end

    let(:user_session) { build(:user_session, session_attributes) }

    let(:additional_duty_rows) { [] }

    context 'when the measure is an ad valorem measure' do
      let(:measure_component) do
        {
          duty_amount: 5.0,
          duty_expression_id: '01',
        }
      end

      let(:expected_table) do
        {
          warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
          footnote: I18n.t('measure_type_footnotes.103'),
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source, option_type: 'Third-country duty', additional_code: nil), '5.00% * £1,050.00', '£52.50'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '<strong>£52.50</strong>'],
          ],
        }
      end

      it 'produces a correct option' do
        expect(service.option).to eq(expected_table)
      end
    end

    context 'when the measure is not an ad valorem but has applicable unit measures' do
      let(:commodity_code) { '0103921100' }

      let(:measure) do
        Api::Measure.new(
          id: 2_046_828,
          duty_expression: {
            base: '35.10 EUR / 100 kg',
            formatted_base: "<span>35.10</span> EUR / <abbr title='Hectokilogram'>100 kg</abbr>",
          },
          measure_type: {
            description: 'Third country duty',
            national: nil,
            measure_type_series_id: 'C',
            id: '103',
          },
          measure_conditions: [],
          measure_components: [measure_component],
        )
      end

      let(:measure_component) do
        {
          'duty_expression_id' => '01',
          'duty_amount' => 35.1,
          'monetary_unit_code' => 'EUR',
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => 'DTN',
          'duty_expression_description' => '% or amount',
          'duty_expression_abbreviation' => '%',
          'measurement_unit_qualifier_code' => nil,
        }
      end

      let(:session_attributes) do
        {
          'import_date' => '2022-01-01',
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

      let(:expected_table) do
        {
          warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
          footnote: I18n.t('measure_type_footnotes.103'),
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_quantity'), nil, '120.0 x 100 kg'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source, option_type: 'Third-country duty', additional_code: nil), '35.10 EUR / 100 kg * 120.0', '£3,596.12'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '<strong>£3,596.12</strong>'],
          ],
        }
      end

      it 'produces a correct option' do
        expect(service.option).to eq(expected_table)
      end
    end

    context 'when the measure is a compound measure' do
      let(:commodity_code) { '0103921100' }

      let(:measure) do
        Api::Measure.new(
          'id' => 2_046_828,
          measure_type: { id: '103' },
          'duty_expression' => {
            'base' => 'foo',
            'formatted_base' => 'foo',
          },
          'measure_components' => measure_components,
        )
      end

      let(:measure_components) do
        [
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
        ]
      end

      let(:session_attributes) do
        {
          'import_date' => '2022-01-01',
          'customs_value' => {
            'monetary_value' => '1000',
            'shipping_cost' => '40',
            'insurance_cost' => '10',
          },
          'measure_amount' => {
            'dtn' => '1',
          },
          'commodity_source' => commodity_source,
          'commodity_code' => commodity_code,
        }
      end

      let(:expected_table) do
        {
          warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
          footnote: I18n.t('measure_type_footnotes.103'),
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source, option_type: 'Third-country duty', additional_code: nil), 'foo', '£15.00'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '<strong>£15.00</strong>'],
          ],
        }
      end

      it 'produces a correct option' do
        expect(service.option).to eq(expected_table)
      end
    end
  end
end
