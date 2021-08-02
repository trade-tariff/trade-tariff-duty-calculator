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

    def user_session
      UserSession.get
    end
  end
end
