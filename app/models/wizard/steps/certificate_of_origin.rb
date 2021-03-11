module Wizard
  module Steps
    class CertificateOfOrigin < Wizard::Steps::Base
      OPTIONS = [
        OpenStruct.new(id: 'yes', name: 'Yes, I have a valid Certificate of Origin'),
        OpenStruct.new(id: 'no', name: 'No, I do not have a valid Certificate of Origin'),
      ].freeze

      STEPS_TO_REMOVE_FROM_SESSION = %w[
        customs_value
      ].freeze

      attribute :certificate_of_origin, :string

      validates :certificate_of_origin, presence: true

      def certificate_of_origin
        super || user_session.certificate_of_origin
      end

      def save
        user_session.certificate_of_origin = certificate_of_origin
      end

      def next_step_path(service_choice:, commodity_code:)
        return duty_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.certificate_of_origin == 'yes'

        customs_value_path(service_choice: service_choice, commodity_code: commodity_code)
      end

      def previous_step_path(service_choice:, commodity_code:)
        return planned_processing_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.planned_processing == 'commercial_purposes'
        return final_use_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.final_use == 'no'

        trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.trader_scheme == 'no'
      end
    end
  end
end
