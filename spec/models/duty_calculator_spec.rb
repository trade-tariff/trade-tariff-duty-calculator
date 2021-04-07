RSpec.describe DutyCalculator do
  subject(:calculator) { described_class.new(user_session, commodity) }

  let(:user_session) { UserSession.new(session) }
  let(:commodity_source) { :xi }
  let(:commodity_code) do
    '7202118000'
  end

  let(:commodity) do
    Api::Commodity.build(
      commodity_source,
      commodity_code,
    )
  end

  describe '#result' do
    context 'when importing from NI to GB' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'UK',
            'country_of_origin' => 'XI',
          },
        }
      end

      it 'returns nil' do
        expect(calculator.result).to be_nil
      end
    end

    context 'when importing from an EU country to NI' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'XI',
            'country_of_origin' => 'RO',
          },
        }
      end

      it 'returns nil' do
        expect(calculator.result).to be_nil
      end
    end

    context 'when importing from GB to NI' do
      context 'when there is no trade defence but a zero_mfn_duty' do
        let(:session) do
          {
            'answers' => {
              'import_destination' => 'XI',
              'country_of_origin' => 'GB',
            },
            'trade_defence' => false,
            'zero_mfn_duty' => true,
          }
        end

        it 'returns nil' do
          expect(calculator.result).to be_nil
        end
      end

      context 'when there is no processing method' do
        let(:session) do
          {
            'answers' => {
              'import_destination' => 'XI',
              'country_of_origin' => 'GB',
              'planned_processing' => 'without_any_processing',
              'customs_value' => {
                'monetary_value' => '1000',
                'shipping_cost' => '250.89',
                'insurance_cost' => '10',
              },
            },
            'commodity_source' => 'UK',
          }
        end

        it 'returns nil' do
          expect(calculator.result).to be_nil
        end
      end

      context 'when there is a certificate of origin' do
        let(:session) do
          {
            'answers' => {
              'import_destination' => 'XI',
              'country_of_origin' => 'GB',
              'certificate_of_origin' => 'yes',
            },
            'commodity_source' => 'UK',
          }
        end

        it 'returns nil' do
          expect(calculator.result).to be_nil
        end
      end

      context 'when the measure is ad valorem and measure type is MFN' do
        let(:expected_result) do
          {
            third_country_duty: {
              warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
              values: [
                [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,260.89'],
                [I18n.t('duty_calculations.options.import_duty_html', commodity_source: 'UK', option_type: 'Third-country duty'), '2.7% * £1,260.89', '£34.04'],
                [I18n.t('duty_calculations.options.duty_total_html'), nil, '£34.04'],
              ],
            },
            tariff_preference: {
              warning_text: nil,
              values: [
                [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,260.89'],
                [I18n.t('duty_calculations.options.import_duty_html', commodity_source: 'UK', option_type: 'Tariff preference'), '0.0% * £1,260.89', '£0.00'],
                [I18n.t('duty_calculations.options.duty_total_html'), nil, '£0.00'],
              ],
            },
          }
        end

        let(:session) do
          {
            'answers' => {
              'import_destination' => 'XI',
              'country_of_origin' => 'GB',
              'planned_processing' => 'commercial_purposes',
              'customs_value' => {
                'monetary_value' => '1000',
                'shipping_cost' => '250.89',
                'insurance_cost' => '10',
              },
            },
            'commodity_source' => 'UK',
          }
        end

        it 'returns the correct duty options' do
          expect(calculator.result).to eq(expected_result)
        end
      end
    end
  end
end
