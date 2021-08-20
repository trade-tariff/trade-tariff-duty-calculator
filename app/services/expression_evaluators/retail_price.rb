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
      presented_unit[:answer].to_f
    end

    def presented_unit
      @presented_unit ||= {
        answer: user_session.measure_amount[component.unit.downcase.to_s],
        unit: applicable_unit['unit'],
      }
    end

    def applicable_unit
      ApplicableMeasureUnitMerger.new.call[component.unit]
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
