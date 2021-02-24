module Wizard
  module Steps
    class CountryOfOrigin < Base
      STEP_ID = '3'.freeze

      attribute 'geographical_area_id', :string

      validates :geographical_area_id, presence: true

      def geographical_area_id
        super || user_session.geographical_area_id
      end

      def save
        user_session.geographical_area_id = geographical_area_id
      end

      def self.options_for(service)
        Country.list(service.to_sym)
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
