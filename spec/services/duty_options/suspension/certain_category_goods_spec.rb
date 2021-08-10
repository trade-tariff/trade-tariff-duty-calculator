RSpec.describe DutyOptions::Suspension::CertainCategoryGoods, :user_session do
  include_context 'with a standard duty option setup', :certain_category_goods

  describe '#option' do
    let(:expected_table) do
      {
        footnote: I18n.t('measure_type_footnotes.117'),
        warning_text: nil,
        values: [
          ['Valuation for import', 'Value of goods + freight + insurance costs', '£1,200.00'],
          ['Import duty<br><span class="govuk-green govuk-body-xs"> Suspension - goods for certain categories of ships, boats and other vessels and for drilling or production platforms (UK)</span>', '8.00% * £1200.00', '£96.00'],
          ['<strong>Duty Total</strong>', nil, '<strong>£96.00</strong>'],
        ],
        value: 96,
        measure_sid: measure.id,
        source: 'uk',
        category: :suspension,
        priority: 3,
      }
    end

    it { expect(duty_option.option).to eq(expected_table) }
  end
end
