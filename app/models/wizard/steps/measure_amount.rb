module Wizard
  module Steps
    class MeasureAmount < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      dynamic_attributes :applicable_measure_units

      def next_step_path(service_choice:, commodity_code:); end

      def previous_step_path(service_choice:, commodity_code:); end
    end
  end
end
