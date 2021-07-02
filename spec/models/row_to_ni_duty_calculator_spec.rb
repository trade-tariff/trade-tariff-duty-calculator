RSpec.describe RowToNiDutyCalculator do
  subject(:calculator) { described_class.new(user_session) }

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_import_date,
      :with_import_destination,
      :with_country_of_origin,
      :with_trader_scheme,
      :with_certificate_of_origin,
      :with_customs_value,
      :with_measure_amount,
      :with_vat,
      :with_additional_codes,
    )
  end

  let(:third_country_tariff_option) do
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
    }
  end

  describe '#options' do
    before do
      # allow(DutyCalculator).to receive(:new).and_return(instance_double('DutyCalculator', options: options))
      allow(DutyOptions::Chooser).to receive(:new).and_call_original
    end

    context 'when there are tariff preferences in both duty calculations' do
      it 'passes the uk preference option and the eu preference option'
    end

    context 'when there is a tariff preference only in the uk duty calculation' do
      it 'passes the uk preference option and the eu mfn option'
    end

    context 'when there is a tariff preference only in the eu duty calculation' do
      it 'returns the eu tariff preference'
      it 'does not pass a tariff preference'
    end

    context 'when there are multiple tariff preferences in the both duty calculations' do
      it 'returns the result of the duty option chooser'
      it 'passes the uk tariff preferences and the cheapest eu preference'
    end

    context 'when there are multiple tariff preferences in the eu duty calculation and none in the uk duty calculation' do
      it 'returns the eu tariff preferences'
      it 'does not pass a tariff preference'
    end

    it 'returns something' do
      build(:duty_option_result, :third_country_tariff)
      # expect(calculator.options.as_json).to include(third_country_tariff_option)
    end
  end
end
