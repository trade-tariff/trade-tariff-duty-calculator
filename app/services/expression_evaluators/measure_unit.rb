module ExpressionEvaluators
  class MeasureUnit < ExpressionEvaluators::Base
    include CommodityHelper

    def call
      {
        calculation: calculation_duty_expression,
        value: value,
        formatted_value: number_to_currency(value),
        unit: measure_unit_answers.first[:unit],
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

      expression = "#{expression} * #{quantity_string.call}"

      sanitize(expression, tags: %w[span abbr], attributes: %w[title])
    end

    def quantity_string
      NumberWithHighPrecisionFormatter.new(total_quantity)
    end

    def value
      @value ||= begin
        return total_quantity * component.duty_amount * eur_to_gbp_rate if duty_amount_in_eur?

        total_quantity * component.duty_amount
      end
    end

    def total_quantity
      measure_unit_answers.first[:answer].to_f
    end

    def measure_unit_answers
      @measure_unit_answers ||= measure_applicable_units.map do |unit, values|
        {
          answer: user_session.measure_amount[unit.downcase.to_s],
          unit: values['unit'],
        }
      end
    end

    def measure_applicable_units
      units = ApplicableMeasureUnitMerger.new.call

      units.select do |_unit, values|
        values['measure_sids'].include?(measure.id)
      end
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
