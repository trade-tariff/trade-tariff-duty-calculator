RSpec.describe ThirdCountryTariffTable do
  subject(:table) { described_class.new(measure, user_session, additional_duty_rows) }

  describe '#rows' do
    context 'when the measure is an ad valorem measure' do
      let(:measure) do
        Api::Measure.new(
          measure_components: [measure_component],
          measure_conditions: [],
        )
      end

      let(:commodity_source) { 'XI' }

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
        }
      end

      let(:user_session) do
        UserSession.new(session)
      end

      let(:measure_component) { { duty_amount: 5.0, duty_expression_id: '01' } }
      let(:additional_duty_rows) { [] }

      let(:expected_table) do
        {
          warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
          values: [
            [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1050.0'],
            [I18n.t('duty_calculations.options.import_duty_html', commodity_source: commodity_source), '5.0% * £1050.0', '£52.5'],
            [I18n.t('duty_calculations.options.duty_total_html'), nil, '£52.5'],
          ],
        }
      end

      it 'produces a correct table' do
        expect(table.option).to eq(expected_table)
      end
    end
  end
end
