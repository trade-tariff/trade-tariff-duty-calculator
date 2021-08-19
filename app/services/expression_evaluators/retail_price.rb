module ExpressionEvaluators
  class RetailPrice < ExpressionEvaluators::Base
    def call
      {
        calculation: "#{number_to_percentage(component.duty_amount)} * #{number_to_currency(total_amount)}",
        value: value,
        formatted_value: number_to_currency(value),
      }
    end

    private

    def value
      @value ||= total_amount / 100.0 * component.duty_amount
    end

    def total_amount
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
