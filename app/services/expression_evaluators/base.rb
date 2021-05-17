module ExpressionEvaluators
  class Base
    include ActionView::Helpers::NumberHelper

    def initialize(measure, component, user_session)
      @measure = measure
      @component = component
      @user_session = user_session
    end

    protected

    attr_reader :measure, :component, :user_session
  end
end
