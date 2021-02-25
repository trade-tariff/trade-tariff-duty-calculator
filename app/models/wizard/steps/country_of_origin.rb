module Wizard
  module Steps
    class CountryOfOrigin < Wizard::Steps::Base
      STEP_ID = '3'.freeze

      attribute 'country_of_origin', :string

      validates :country_of_origin, presence: true

      def country_of_origin
        super || user_session.country_of_origin
      end

      def save
        user_session.country_of_origin = country_of_origin
      end

      def self.options_for(service)
        Api::GeographicalArea.list_countries(service.to_sym)
      end

      def next_step_path(service_choice:, commodity_code:)
        duty_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.ni_to_gb_route? || user_session.eu_to_ni_route?
      end

      def previous_step_path(service_choice:, commodity_code:)
        import_destination_path(service_choice: service_choice, commodity_code: commodity_code)
      end
    end
  end
end
