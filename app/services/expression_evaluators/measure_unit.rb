module ExpressionEvaluators
  class MeasureUnit < ExpressionEvaluators::Base
    include CommodityHelper
    include MeasureUnitHelper

    def call
      {
        calculation: calculation_duty_expression,
        value: value,
        formatted_value: number_to_currency(value),
        unit: presented_unit[:unit],
        total_quantity: total_quantity,
      }
    end

    private

    def calculation_duty_expression
      expression =
        if measure_condition.present?
          measure_condition.duty_expression
        else
          measure.duty_expression.formatted_base
        end

      expression = "#{expression} * #{quantity_string}"

      sanitize(expression, tags: %w[span abbr], attributes: %w[title])
    end

    def quantity_string
      NumberWithHighPrecisionFormatter.new(total_quantity).call
    end

    def value
      @value ||= begin
        return total_quantity * component.duty_amount * eur_to_gbp_rate if duty_amount_in_eur?

        total_quantity * component.duty_amount
      end
    end

    def total_quantity
      presented_unit[:answer].to_f
    end

    def applicable_unit
      ApplicableMeasureUnitMerger.new.call[component.unit]
    end

    def eur_to_gbp_rate
      Api::MonetaryExchangeRate.for('GBP').exchange_rate
    end

    def duty_amount_in_eur?
      component.monetary_unit_code == 'EUR'
    end

    def measure_condition
      return nil if component.is_a?(Api::MeasureComponent)

      measure.measure_conditions.find do |measure_condition|
        measure_condition.measure_condition_components.any? do |measure_condition_component|
          measure_condition_component.eql?(component)
        end
      end
    end
  end
end
