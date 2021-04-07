RSpec.describe DutyOptions::ThirdCountryTariffOption do
  subject(:option) { described_class.new(measure, user_session, additional_duty_rows) }

  describe '#rows' do
    let(:commodity_source) { 'XI' }
    let(:commodity_code) { '0702000007' }

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
          warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source, option_type: 'Third-country duty'), '5.0% * £1,050.00', '£52.50'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '£52.50'],
          ],
        }
      end

      it 'produces a correct option' do
        expect(option.option).to eq(expected_table)
      end
    end

    context 'when the measure is not an ad valorem but has applicable unit measures' do
      let(:commodity_code) { '0103921100' }

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
          warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,050.00'],
            [I18n.t('duty_calculations.options.import_quantity'), nil, '120.0 x 100 kg'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source, option_type: 'Third-country duty'), '35.10 EUR / 100 kg * 120.0', '£3,596.12'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '£3,596.12'],
          ],
        }
      end

      it 'produces a correct option' do
        expect(option.option).to eq(expected_table)
      end
    end
  end
end
