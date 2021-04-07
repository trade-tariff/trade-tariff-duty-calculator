module ExpressionEvaluators
  class Base
    include ActionView::Helpers::NumberHelper

    def initialize(measure, user_session)
      @measure = measure
      @user_session = user_session
    end

    protected

    def component
      @component || measure.component
    end

    attr_reader :measure, :user_session
    attr_writer :component
  end
end
