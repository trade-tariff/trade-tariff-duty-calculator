RSpec.describe RowToNiDutyCalculator do
  subject(:calculator) { described_class.new(user_session) }

  let(:user_session) { build(:user_session, session_attributes) }

  let(:commodity_code) { '0103921100' }

  let(:expected_result) do
    [
      {
        key: 'third_country_tariff',
        evaluation: {
          footnote: "<p class=\"govuk-body\">\n  A ‘Third country’ duty is the tariff charged where there isn’t a trade agreement or a customs union available. It can also be referred to as the Most Favoured Nation (<abbr title=\"Most Favoured Nation\">MFN</abbr>) rate.\n</p>",
          warning_text: 'Third-country duty will apply as there is no preferential agreement in place for the import of this commodity.',
          values: [
            ['Valuation for import', 'Value of goods + freight + insurance costs', '£1,260.89'],
            ['Import quantity', nil, '0.0 x 100 kg'],
            ['Import duty<br><span class="govuk-green govuk-body-xs"> Third-country duty (UK)</span>', '35.10 EUR / 100 kg * 0.0', '£0.00'],
            ['<strong>Duty Total</strong>', nil, '<strong>£0.00</strong>'],
          ],
          value: 0.0,
        },
        priority: 1,
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

  describe '#result' do
    it 'returns something' do
      expect(calculator.result).to eq(expected_result)
    end
  end
end
