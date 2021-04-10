module Wizard
  module Steps
    class Confirmation < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      def next_step_path
        duty_path
      end

      def previous_step_path
        return measure_amount_path unless user_session.measure_amount.empty?

        customs_value_path
      end
    end
  end
end
