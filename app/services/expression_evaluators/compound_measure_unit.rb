module ExpressionEvaluators
  class CompoundMeasureUnit < ExpressionEvaluators::Base
    include MeasureUnitPresentable

    def call
      {
        calculation: calculation_duty_expression,
        value:,
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
      presented_volume_unit[:answer].to_f * presented_volume_unit[:multiplier].to_f
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
        multiplier: volume_unit_multiplier,
      }
    end

    def volume_unit_multiplier
      volume_unit['multiplier'].presence || 1
    end
  end
end
