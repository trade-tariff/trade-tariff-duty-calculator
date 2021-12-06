module ExpressionEvaluators
  class CompoundMeasureUnit < ExpressionEvaluators::Base
    include MeasureUnitPresentable

    def call
      {
        calculation: calculation_duty_expression,
        value: value,
        formatted_value: number_to_currency(value),
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

      sanitize(expression, tags: %w[span abbr], attributes: %w[title])
    end

    def value
      return component.duty_amount * alcohol_quantity * volume_quantity * euro_exchange_rate if component.euros?

      component.duty_amount * alcohol_quantity * volume_quantity
    end

    def alcohol_quantity
      presented_alcohol_unit[:answer].to_f
    end

    def volume_quantity
      presented_volume_unit[:answer].to_f
    end

    def alcohol_unit
      applicable_units[Api::BaseComponent::ALCOHOL_UNIT]
    end

    def volume_unit
      applicable_units[Api::BaseComponent::VOLUME_UNIT]
    end

    def presented_alcohol_unit
      @presented_alcohol_unit ||= {
        answer: user_session.measure_amount[Api::BaseComponent::ALCOHOL_UNIT.downcase],
        unit: alcohol_unit['unit'],
      }
    end

    def presented_volume_unit
      @presented_volume_unit ||= {
        answer: user_session.measure_amount[Api::BaseComponent::VOLUME_UNIT.downcase],
        unit: volume_unit['unit'],
      }
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
      Api::MonetaryExchangeRate.for('GBP').exchange_rate
    end
  end
end
