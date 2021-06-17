module DutyOptions
  module AdditionalDuty
    class Vat < DutyOptions::AdditionalDuty::Base
      def duty_calculation_row
        presented_rows = []

        presented_rows << I18n.t(
          'duty_calculations.options.vat_duty_html',
          option_type: option_type,
        ).html_safe

        presented_rows.concat(duty_evaluation.slice(:calculation, :formatted_value).values)
      end

      private

      def option_type
        I18n.t("duty_calculations.options.option_type.vat_type.#{measure.vat_type.downcase}")
      end
    end
  end
end
