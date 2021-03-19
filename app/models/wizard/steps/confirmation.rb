module Wizard
  module Steps
    class Confirmation < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      def next_step_path; end

      def previous_step_path
        return measure_amount_path if user_session.gb_to_ni_route?
      end
    end
  end
end
