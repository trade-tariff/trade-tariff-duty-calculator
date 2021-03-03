module Wizard
  module Steps
    class PlannedProcessing < Wizard::Steps::Base
      OPTIONS = [
          OpenStruct.new(id: 1, name: 'test'),
          OpenStruct.new(id: 0, name: 'test'),
      ].freeze

      STEP_ID = '7'.freeze

      attribute :planned_processing, :string

      validates :planned_processing, presence: true

      def planned_processing
        super || user_session.planned_processing
      end

      def save
        user_session.planned_processing = planned_processing
      end

      def next_step_path(service_choice:, commodity_code:)
        # To be added on the ticket that creates the next step
      end

      def previous_step_path(service_choice:, commodity_code:)
        trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end
    end
  end
end
