RSpec.describe DutyOptions::AdditionalDuty::ProvisionalCountervailing, :user_session do
  include_context 'with a standard duty option setup', :provisional_countervailing

  describe '#option' do
    let(:expected_table) do
      {
        footnote: nil,
        warning_text: nil,
        values: [
          ['Import duty<br><span class="govuk-green govuk-body-xs"> Provisional countervailing duty (UK)</span>', '8.00% * £1200.00', '£96.00'],
        ],
        value: 96,
        measure_sid: measure.id,
        source: nil,
        category: :additional_duty,
        priority: 5,
      }
    end

    it { expect(duty_option.option).to eq(expected_table) }
  end
end
