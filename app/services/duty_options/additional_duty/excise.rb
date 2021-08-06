module DutyOptions
  module AdditionalDuty
    class Excise < DutyOptions::AdditionalDuty::Base
      PRIORIY = 6

      include CommodityHelper

      def duty_calculation_row
        presented_row = []
        presented_row << I18n.t(
          'duty_calculations.options.excise_duty_html',
          additional_code_description: excise_description,
        ).html_safe

        presented_row.concat(duty_evaluation.slice(:calculation, :formatted_value).values)
      end

      def excise_description
        additional_code = uk_filtered_commodity.applicable_additional_codes.dig(measure.measure_type.id, 'additional_codes').find do |code|
          code['code'] == "X#{user_session.additional_code_for(measure.measure_type)}"
        end
        additional_code['overlay'].presence || measure.additional_code.formatted_description.presence || measure.additional_code.description
      end
    end
  end
end
