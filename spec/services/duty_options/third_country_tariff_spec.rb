RSpec.describe DutyOptions::ThirdCountryTariff, :user_session do
  include_context 'with a standard duty option setup', :third_country_tariff

  describe '#option' do
    let(:expected_table) do
      {
        footnote: "<p class=\"govuk-body\">\n  A ‘Third country’ duty is the tariff charged where there isn’t a trade agreement or a customs union available. It can also be referred to as the Most Favoured Nation (<abbr title=\"Most Favoured Nation\">MFN</abbr>) rate.\n</p>",
        warning_text: 'Third-country duty will apply as there is no preferential agreement in place for the import of this commodity.',
        values: [
          ['Valuation for import', 'Value of goods + freight + insurance costs', '£1,200.00'],
          ['Import duty<br><span class="govuk-green govuk-body-xs"> Third-country duty (UK)</span>', '8.00% * £1200.00', '£96.00'],
          ['<strong>Duty Total</strong>', nil, '<strong>£96.00</strong>'],
        ],
        value: 96,
        measure_sid: measure.id,
        source: nil,
        category: :third_country_tariff,
        priority: 1,
      }
    end

    it { expect(duty_option.option).to eq(expected_table) }
  end
end
