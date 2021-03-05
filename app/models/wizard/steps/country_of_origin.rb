module Wizard
  module Steps
    class CountryOfOrigin < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[
        customs_value
        trader_scheme
        final_use
        certificate_of_origin
      ].freeze

      attr_reader :zero_mfn_duty, :trade_defence

      attribute :country_of_origin, :string

      validates :country_of_origin, presence: true

      def initialize(user_session, attributes = {}, opts = {})
        super(user_session, attributes)

        @zero_mfn_duty = opts[:zero_mfn_duty]
        @trade_defence = opts[:trade_defence]
      end

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
        return duty_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.ni_to_gb_route? || user_session.eu_to_ni_route?

        return next_step_for_gb_to_ni(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end

      def previous_step_path(service_choice:, commodity_code:)
        import_destination_path(service_choice: service_choice, commodity_code: commodity_code)
      end

      private

      def next_step_for_gb_to_ni(service_choice:, commodity_code: )
        return trade_remedy_path(service_choice: service_choice, commodity_code: commodity_code) if trade_defence
        return duty_path(service_choice: service_choice, commodity_code: commodity_code) if zero_mfn_duty

        trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code)
      end
    end
  end
end
