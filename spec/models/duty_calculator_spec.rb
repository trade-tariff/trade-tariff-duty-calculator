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

      context 'when the measure has components to be calculated' do
        let(:expected_result) do
          [
            {
              key: 'third_country_tariff',
              evaluation: {
                warning_text: 'Third-country duty will apply as there is no preferential agreement in place for the import of this commodity.',
                values: [
                  ['Valuation for import', 'Value of goods + freight + insurance costs', '£1,260.89'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Third-country duty (UK)</span>', '2.7% * £1,260.89', '£34.04'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '£322.24'],
                ],
                footnote: I18n.t('measure_type_footnotes.103'),
              },
              priority: 1,
            },
            {
              key: 'tariff_preference',
              evaluation: {
                warning_text: nil,
                values: [
                  ['Valuation for import', 'Value of goods + freight + insurance costs', '£1,260.89'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Tariff preference (UK)</span>', '0.0% * £1,260.89', '£0.00'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '£288.20'],
                ],
                geographical_area_description: 'United Kingdom (excluding Northern Ireland)',
                footnote: I18n.t('measure_type_footnotes.142'),
              },
              priority: 2,
            },
            {
              key: 'non_preferential',
              evaluation: {
                warning_text: nil,
                values: [
                  ['Valuation for import', 'Value of goods + freight + insurance costs', '£1,260.89'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Non Preferential Quota (UK)</span>', '20.0% * £1,260.89', '£252.18'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '£540.38'],
                ],
                footnote: I18n.t('measure_type_footnotes.122'),
                order_number: '054003',
              },
              priority: 3,
            },
            {
              key: 'certain_category_goods',
              evaluation: {
                warning_text: nil,
                values: [
                  ['Valuation for import', 'Value of goods + freight + insurance costs', '£1,260.89'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Suspension - goods for certain categories of ships, boats and other vessels and for drilling or production platforms (UK)</span>', '0.0% * £1,260.89', '£0.00'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '£288.20'],
                ],
                footnote: I18n.t('measure_type_footnotes.117'),
              },
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
              'measure_amount' => { 'tnei' => '2' },
            },
            'commodity_source' => 'UK',
            'commodity_code' => commodity_code,
          }
        end

        it 'returns the correct duty options' do
          expect(calculator.result).to eq(expected_result)
        end
      end
    end
  end
end
