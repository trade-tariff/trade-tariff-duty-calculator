module ExpressionEvaluators
  class MeasureUnit < ExpressionEvaluators::Base
    include CommodityHelper
    include MeasureUnitPresentable

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
        return total_quantity * component.duty_amount * euro_exchange_rate if component.euros?

        total_quantity * component.duty_amount
      end
    end

    def total_quantity
      presented_unit[:answer].to_f
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

    def euro_exchange_rate
      Api::MonetaryExchangeRate.for('GBP').euro_exchange_rate
    end
  end
end
