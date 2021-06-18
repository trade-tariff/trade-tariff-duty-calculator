module ExpressionEvaluators
  class MeasureUnit < ExpressionEvaluators::Base
    include CommodityHelper

    def call
      {
        calculation: "#{measure.duty_expression.base} * #{total_quantity}",
        value: value,
        formatted_value: number_to_currency(value),
        unit: measure_unit_answers.first[:unit],
        total_quantity: total_quantity,
      }
    end

    private

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
      filtered_commodity.applicable_measure_units.select do |_unit, values|
        values['measure_sids'].include?(measure.id)
      end
    end

    def eur_to_gbp_rate
      Api::ExchangeRate.for('GBP').rate
    end

    def duty_amount_in_eur?
      component.monetary_unit_code == 'EUR'
    end

    def query
      {
        'as_of' => user_session.import_date.iso8601,
        'filter[geographical_area_id]' => user_session.country_of_origin,
      }
    end
  end
end
