module Wizard
  module Steps
    class DutyController < BaseController
      def show
        @duty_option = DutyCalculator.new(user_session, filtered_commodity).result
      end
    end
  end
end
