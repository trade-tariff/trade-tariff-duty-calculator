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
          [
            {
              evaluation: {
                warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
                values: [
                  [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,260.89'],
                  [I18n.t('duty_calculations.options.import_duty_html', commodity_source: 'UK', option_type: 'Third-country duty'), '2.7% * £1,260.89', '£34.04'],
                  [I18n.t('duty_calculations.options.duty_total_html'), nil, '£34.04'],
                ],
              },
              key: 'third_country_tariff',
              priority: 1,
            },
            {
              evaluation: {
                warning_text: nil,
                values: [
                  [I18n.t('duty_calculations.options.import_valuation'), I18n.t('duty_calculations.options.customs_value'), '£1,260.89'],
                  [I18n.t('duty_calculations.options.import_duty_html', commodity_source: 'UK', option_type: 'Tariff preference'), '0.0% * £1,260.89', '£0.00'],
                  [I18n.t('duty_calculations.options.duty_total_html'), nil, '£0.00'],
                ],
              },
              key: 'tariff_preference',
              priority: 2,
            },
            {
              evaluation:
              {
                footnote: '<p class="govuk-body">1. Customs duties may be suspended in respect of goods intended for incorporation in ships, boats or other vessels classified at the following CN codes 8901 10 10; 8901 20 10; 8901 30 10; 8901 90 10; 8902 00 10; 8903 91 10; 8903 92 10; 8904 00 10; 8904 00 91; 8905 10 10; 8905 90 10; 8906 10 00; 8906 90 10 for the purposes of their construction, repair, maintenance or conversion, and in respect of goods intended for fitting to or equipping such ships, boats or other vessels.</p><p class="govuk-body">2. Customs duties shall be suspended in respect of:<br> (a) goods intended for incorporation in drilling or production platforms:<br> (1) fixed, of subheading ex 8430 49, operating in or outside the territorial sea of Member States, or<br> (2) floating or submersible, of subheading 8905 20, for the purposes of their construction, repair, maintenance or conversion, and in respect of goods intended for equipping the said platforms.<br> (b) tubes, pipes, cables and their connection pieces, linking these drilling or production platforms to the mainland.<br> Goods intended for incorporation in drilling or production platforms:<br> Those goods such as motor fuel, lubricants and gas, which are necessary for the operation of machines and apparatus which do not affect permanently, and are not integral parts of the platforms and which are used on board for the construction, repair, maintenance, conversion or equipping of these platforms are regarded also as being used for incorporation in drilling or production platforms. </p>',
                values: [
                  ['Valuation for import',
                   'Value of goods + freight + insurance costs',
                   '£1,260.89'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Suspension - goods for certain categories of ships, boats and other vessels and for drilling or production platforms (UK)</span>', '0.0% * £1,260.89', '£0.00'],
                  ['<strong>Duty Total</strong>', nil, '£0.00'],
                ],
                warning_text: nil,
              },
              key: 'certain_category_goods',
              priority: 3,
            },
          ]
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
