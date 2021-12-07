module ExpressionEvaluators
  class Base
    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::SanitizeHelper

    def initialize(measure, component, duty_total = nil)
      @measure = measure
      @component = component
      @duty_total = duty_total
    end

    protected

    attr_reader :measure, :component, :duty_total

    def measure_condition
      if component.belongs_to_measure_condition?
        measure.measure_conditions.find do |measure_condition|
          measure_condition.id == component.measure_condition_sid
        end
      end
    end

    def user_session
      UserSession.get
    end

    def euro_exchange_rate
      Api::MonetaryExchangeRate.for('GBP').exchange_rate
    end
  end
end
