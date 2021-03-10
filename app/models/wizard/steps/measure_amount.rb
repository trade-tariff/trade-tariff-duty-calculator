module Wizard
  module Steps
    class MeasureAmount < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      dynamic_attributes :applicable_measure_units

      def next_step_path(service_choice:, commodity_code:)
        # TODO: Build the confirm page and make that the next step
      end

      def previous_step_path(service_choice:, commodity_code:)
        customs_value_path(service_choice: service_choice, commodity_code: commodity_code)
      end
    end
  end
end
