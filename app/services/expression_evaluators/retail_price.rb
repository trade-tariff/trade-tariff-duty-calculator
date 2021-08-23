module ExpressionEvaluators
  class RetailPrice < ExpressionEvaluators::Base
    include MeasureUnitHelper

    def call
      {
        calculation: calculation_duty_expression,
        value: value,
        formatted_value: number_to_currency(value),
      }
    end

    private

    def calculation_duty_expression
      "#{number_to_percentage(component.duty_amount)} * #{number_to_currency(total_amount)}"
    end

    def value
      @value ||= total_amount / 100.0 * component.duty_amount
    end

    def total_amount
      presented_unit[:answer].to_f
    end
  end
end
