module ExpressionEvaluators
  class Base
    include ActionView::Helpers::NumberHelper

    def initialize(measure, user_session)
      @measure = measure
      @user_session = user_session
    end

    protected

    attr_reader :measure, :user_session
  end
end
