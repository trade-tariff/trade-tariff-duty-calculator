module ExpressionEvaluators
  class MeasureUnit < ExpressionEvaluators::Base
    include CommodityHelper

    def call
      quantity_string = NumberWithHighPrecisionFormatter.new(total_quantity)

      {
        calculation: "#{base_duty_expression} * #{quantity_string.call}",
        value: value,
        formatted_value: number_to_currency(value),
        unit: measure_unit_answers.first[:unit],
        total_quantity: total_quantity,
      }
    end

    private

    def base_duty_expression
      return measure.duty_expression.base if measure_condition.nil?

      strip_tags(measure_condition.duty_expression)
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
      unless user_session.deltas_applicable?
        return filtered_commodity.applicable_measure_units.select do |_unit, values|
          values['measure_sids'].include?(measure.id)
        end
      end

      convoluted_hashes.select do |_unit, values|
        values['measure_sids'].include?(measure.id)
      end
    end

    def eur_to_gbp_rate
      Api::MonetaryExchangeRate.for('GBP').exchange_rate
    end

    def duty_amount_in_eur?
      component.monetary_unit_code == 'EUR'
    end

    def convoluted_hashes
      @convoluted_hashes ||=
        uk_measure_amounts.merge(xi_measure_amounts) do |_key, uk_amounts, xi_amounts|
          uk_amounts['measure_sids'] += xi_amounts['measure_sids']
          uk_amounts
        end
    end

    def uk_measure_amounts
      @uk_measure_amounts ||= filtered_commodity(source: 'uk').applicable_measure_units
    end

    def xi_measure_amounts
      @xi_measure_amounts ||= filtered_commodity(source: 'xi').applicable_measure_units
    end

    def measure_condition
      return nil if component.is_a? Api::MeasureComponent

      measure.measure_conditions.detect do |measure_condition|
        measure_condition.measure_condition_components.any? do |measure_condition_component|
          measure_condition_component.as_json == component.as_json
        end
      end
    end
  end
end
