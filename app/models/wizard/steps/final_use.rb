module Wizard
  module Steps
    class FinalUse < Wizard::Steps::Base
      OPTIONS = [
        OpenStruct.new(id: 'yes', name: 'Yes, I am importing this good into Northern Ireland for its sale to, or final use by, end-consumers located in the United Kingdom'),
        OpenStruct.new(id: 'no', name: 'No, this import will not be for final use in the United Kingdom'),
      ].freeze

      STEPS_TO_REMOVE_FROM_SESSION = %w[
        certificate_of_origin
        planned_processing
      ].freeze

      attribute :final_use, :string

      validates :final_use, presence: true

      def final_use
        super || user_session.final_use
      end

      def save
        user_session.final_use = final_use
      end

      def next_step_path(service_choice:, commodity_code:)
        return planned_processing_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.final_use == 'yes'
        return certificate_of_origin_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end

      def previous_step_path(service_choice:, commodity_code:)
        trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end
    end
  end
end
