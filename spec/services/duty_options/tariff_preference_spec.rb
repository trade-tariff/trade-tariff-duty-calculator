RSpec.describe DutyOptions::TariffPreference do
  subject(:service) { described_class.new(measure, user_session, additional_duty_rows) }

  describe '#option' do
    let(:commodity_source) { 'xi' }
    let(:commodity_code) { '0702000007' }
    let(:geographical_area_description) { 'GSP – General Framework' }

    let(:session) do
      {
        'answers' => {
          Wizard::Steps::CustomsValue.id => {
            'monetary_value' => '1000',
            'shipping_cost' => '40',
            'insurance_cost' => '10',
          },
        },
        'commodity_source' => commodity_source,
        'commodity_code' => commodity_code,
      }
    end

    let(:measure) do
      Api::Measure.new(
        measure_components: [measure_component],
        measure_conditions: [],
        geographical_area: {
          description: geographical_area_description,
        },
      )
    end

    let(:user_session) do
      UserSession.new(session)
    end

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
          warning_text: nil,
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source.upcase, option_type: 'Tariff preference'), '5.0% * £1,050.00', '£52.50'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '£52.50'],
          ],
          geographical_area_description: 'GSP – General Framework',
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
            id: '142',
          },
          measure_conditions: [],
          measure_components: [
            {
              duty_expression_id: '01',
              duty_amount: 35.1,
              monetary_unit_code: 'EUR',
              monetary_unit_abbreviation: nil,
              measurement_unit_code: 'DTN',
              duty_expression_description: '% or amount',
              duty_expression_abbreviation: '%',
              measurement_unit_qualifier_code: nil,
            },
          ],
          geographical_area: {
            description: geographical_area_description,
          },
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

      let(:session) do
        {
          'answers' => {
            Wizard::Steps::CustomsValue.id => {
              'monetary_value' => '1000',
              'shipping_cost' => '40',
              'insurance_cost' => '10',
            },
            'measure_amount' => {
              'dtn' => '120',
            },
          },
          'commodity_source' => commodity_source,
          'commodity_code' => commodity_code,
        }
      end

      let(:expected_table) do
        {
          warning_text: nil,
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_quantity'), nil, '120.0 x 100 kg'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source.upcase, option_type: 'Tariff preference'), '35.10 EUR / 100 kg * 120.0', '£3,596.12'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '£3,596.12'],
          ],
          geographical_area_description: 'GSP – General Framework',
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
          id: 2_046_828,
          duty_expression: {
            base: 'foo',
            formatted_base: 'foo',
          },
          measure_components: measure_components,
          geographical_area: {
            description: geographical_area_description,
          },
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

      let(:session) do
        {
          'answers' => {
            Wizard::Steps::CustomsValue.id => {
              'monetary_value' => '1000',
              'shipping_cost' => '40',
              'insurance_cost' => '10',
            },
            'measure_amount' => {
              'dtn' => '1',
            },
          },
          'commodity_source' => commodity_source,
          'commodity_code' => commodity_code,
        }
      end

      let(:expected_table) do
        {
          warning_text: nil,
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source.upcase, option_type: 'Tariff preference'), 'foo', '£15.00'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '£15.00'],
          ],
          geographical_area_description: 'GSP – General Framework',
        }
      end

      it 'produces a correct option' do
        expect(service.option).to eq(expected_table)
      end
    end
  end
end
