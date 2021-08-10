RSpec.describe DutyOptions::AdditionalDuty::DefinitiveAntiDumping, :user_session do
  include_context 'with a standard duty option setup', :definitive_anti_dumping

  describe '#option' do
    let(:expected_table) do
      {
        footnote: nil,
        warning_text: nil,
        values: [
          ['Import duty<br><span class="govuk-green govuk-body-xs"> Definitive anti-dumping duty (UK)</span>', '8.00% * £1200.00', '£96.00'],
        ],
        value: 96,
        measure_sid: measure.id,
        source: 'uk',
        category: :additional_duty,
        priority: 5,
      }
    end

    it { expect(duty_option.option).to eq(expected_table) }
  end
end
