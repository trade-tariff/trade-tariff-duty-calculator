module Wizard
  module Steps
    class PlannedProcessing < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[
        certificate_of_origin
      ].freeze

      attribute :planned_processing, :string

      validates :planned_processing, presence: true

      def planned_processing
        super || user_session.planned_processing
      end

      def save
        user_session.planned_processing = planned_processing
      end

      def next_step_path
        return next_step_for_gb_to_ni if user_session.gb_to_ni_route?
      end

      def previous_step_path
        final_use_path
      end

      private

      def next_step_for_gb_to_ni
        return duty_path unless user_session.planned_processing == 'commercial_purposes'

        certificate_of_origin_path
      end
    end
  end
end
