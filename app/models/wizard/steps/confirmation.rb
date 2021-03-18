module Wizard
  module Steps
    class Confirmation < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      def next_step_path(service_choice:, commodity_code:); end

      def previous_step_path(service_choice:, commodity_code:)
        return measure_amount_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end
    end
  end
end
