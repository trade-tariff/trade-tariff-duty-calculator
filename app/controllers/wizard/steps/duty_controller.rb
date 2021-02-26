module Wizard
  module Steps
    class DutyController < BaseController
      def show
        @duty = DutyCalculator.new(user_session).result
      end
    end
  end
end
