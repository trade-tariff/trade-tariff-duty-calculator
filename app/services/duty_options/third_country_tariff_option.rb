module DutyOptions
  class ThirdCountryTariffOption < DutyOptions::Base
    private

    def measure_rows
      presented_rows = []
      presented_rows << measure_unit_row if measure_unit?
      presented_rows << duty_calculation_row
    end

    def duty_calculation_row
      [
        I18n.t('duty_calculations.options.import_duty_html', commodity_source: user_session.commodity_source).html_safe,
      ].concat(
        duty_evaluation.slice(:calculation, :formatted_value).values,
      )
    end

    def measure_unit_row
      [I18n.t('duty_calculations.options.import_quantity'), nil, "#{total_quantity} #{unit}"]
    end

    def measure_unit?
      unit.present?
    end

    def total_quantity
      duty_evaluation[:total_quantity]
    end

    def unit
      duty_evaluation[:unit]
    end
  end
end
