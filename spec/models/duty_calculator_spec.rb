RSpec.describe DutyCalculator do
  subject(:calculator) { described_class.new(user_session, commodity) }

  let(:user_session) { build(:user_session, session_attributes) }
  let(:commodity_source) { :xi }
  let(:commodity_code) { '7202118000' }

  let(:commodity) do
    Api::Commodity.build(
      commodity_source,
      commodity_code,
    )
  end

  describe '#result' do
    context 'when importing from NI to GB' do
      let(:session_attributes) do
        {
          'import_destination' => 'UK',
          'country_of_origin' => 'XI',
        }
      end

      it 'returns nil' do
        expect(calculator.result).to be_nil
      end
    end

    context 'when importing from an EU country to NI' do
      let(:session_attributes) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'RO',
        }
      end

      it 'returns nil' do
        expect(calculator.result).to be_nil
      end
    end

    context 'when importing from GB to NI' do
      context 'when there is no trade defence but a zero_mfn_duty' do
        let(:session_attributes) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'GB',
            'trade_defence' => false,
            'zero_mfn_duty' => true,
          }
        end

        it 'returns nil' do
          expect(calculator.result).to be_nil
        end
      end

      context 'when there is no processing method' do
        let(:session_attributes) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'GB',
            'planned_processing' => 'without_any_processing',
            'customs_value' => {
              'monetary_value' => '1000',
              'shipping_cost' => '250.89',
              'insurance_cost' => '10',
            },
            'commodity_source' => 'UK',
          }
        end

        it 'returns nil' do
          expect(calculator.result).to be_nil
        end
      end

      context 'when there is a certificate of origin' do
        let(:session_attributes) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'GB',
            'certificate_of_origin' => 'yes',
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
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Third-country duty (UK)</span>', '2.70% * £1,260.89', '£34.04'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional duties (safeguard) (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional Duties (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty (C490)<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '<strong>£952.69</strong>'],
                ],
                value: 34.04403,
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
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Tariff preference (UK)</span>', '0.00% * £1,260.89', '£0.00'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional duties (safeguard) (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional Duties (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty (C490)<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '<strong>£918.65</strong>'],
                ],
                value: 0.0,
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
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Non Preferential Quota (UK)</span>', '20.00% * £1,260.89', '£252.18'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional duties (safeguard) (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional Duties (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty (C490)<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '<strong>£1,170.82</strong>'],
                ],
                value: 252.17799999999997,
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
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Suspension - goods for certain categories of ships, boats and other vessels and for drilling or production platforms (UK)</span>', '0.00% * £1,260.89', '£0.00'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional duties (safeguard) (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty<br><span class="govuk-green govuk-body-xs"> Additional Duties (UK)</span>', '25.00% * £1,260.89', '£315.22'],
                  ['Import duty (C490)<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '144.10 GBP / 1000 kg/biodiesel * 2.0', '£288.20'],
                  ['<strong>Duty Total</strong>', nil, '<strong>£918.65</strong>'],
                ],
                value: 0.0,
                footnote: I18n.t('measure_type_footnotes.117'),
              },
              priority: 3,
            },
            {
              key: 'waiver',
              evaluation: {
                footnote: "<p class=\"govuk-body\">\n  A claim for a customs duty waiver for duty on goods that would otherwise incur “at risk” tariffs is provided as “de minimis aid”. The maximum allowance for most sectors is €200,000 across a rolling three tax year period. This allowance includes all de minimis aid you have claimed over a 3 tax year period.\n</p> <p class=\"govuk-body\">\n  This type of aid is measured in euros, so it is important to convert any aid received in pound sterling into euros. You can use this <a target=\"_blank\" href=\"https://ec.europa.eu/info/funding-tenders/procedures-guidelines-tenders/information-contractors-and-beneficiaries/exchange-rate-inforeuro_en\" class=\"govuk-link\">exchange rate tool</a> to calculate the applicable euro equivalent of the value of the aid for the month you were awarded the aid.\n</p>",
                warning_text: nil,
                values: nil,
              },
              priority: 10,
            },
          ]
        end
        let(:session_attributes) do
          {
            'import_date' => '2021-01-01',
            'import_destination' => 'XI',
            'country_of_origin' => 'GB',
            'planned_processing' => 'commercial_purposes',
            'customs_value' => {
              'monetary_value' => '1000',
              'shipping_cost' => '250.89',
              'insurance_cost' => '10',
            },
            'measure_amount' => { 'tnei' => '2' },
            'additional_code' => { '552' => 'C490' },
            'commodity_source' => 'UK',
            'commodity_code' => commodity_code,
          }
        end

        it 'returns the correct duty options' do
          expect(calculator.result).to eq(expected_result)
        end

        context 'when deltas are applicable' do
          let(:user_session) { build(:user_session, :deltas_applicable, :with_commodity_information, :with_customs_value) }

          let(:expected_footnote) do
            "<p class=\"govuk-body\">\n  A ‘Third country’ duty is the tariff charged where there isn’t a trade agreement or a customs union available. It can also be referred to as the Most Favoured Nation (<abbr title=\"Most Favoured Nation\">MFN</abbr>) rate.\n</p><p class=\"govuk-body\">UK import duties apply, as the difference between the UK third country duty and the EU third country duty is lower than 3% of the customs value of your trade.</p>"
          end

          it 'returns the correct 3rd country duty footnote' do
            expect(calculator.result.first[:evaluation][:footnote]).to eq(expected_footnote)
          end
        end
      end
    end
  end
end
