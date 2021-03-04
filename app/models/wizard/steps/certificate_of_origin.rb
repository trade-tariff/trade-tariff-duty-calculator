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
        # To be added on the ticket that creates the next step
      end

      def previous_step_path(service_choice:, commodity_code:)
        if user_session.gb_to_ni_route?
          return final_use_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.final_use == 'no'
          return trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.trader_scheme == 'no'
        end
      end
    end
  end
end
