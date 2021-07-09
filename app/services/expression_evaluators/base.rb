module ExpressionEvaluators
  class Base
    include ActionView::Helpers::NumberHelper

    def initialize(measure, component, user_session, duty_total = nil)
      @measure = measure
      @component = component
      @user_session = user_session
      @duty_total = duty_total
    end

    protected

    attr_reader :measure, :component, :user_session, :duty_total
  end
end
