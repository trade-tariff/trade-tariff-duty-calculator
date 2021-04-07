module Wizard
  module Steps
    class CountryOfOrigin < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[
        trader_scheme
        final_use
        certificate_of_origin
        planned_processing
      ].freeze

      XI_OPTIONS = [
        OpenStruct.new(id: 'UK', name: 'England, Scotland or Wales (GB)'),
        OpenStruct.new(id: 'EU', name: 'Ireland or other EU member states'),
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
        user_session.trade_defence = trade_defence
        user_session.zero_mfn_duty = zero_mfn_duty
      end

      def self.options_for(service)
        Api::GeographicalArea.list_countries(service.to_sym)
      end

      def next_step_path
        return duty_path if user_session.ni_to_gb_route? || user_session.eu_to_ni_route?

        return next_step_for_gb_to_ni if user_session.gb_to_ni_route?
      end

      def previous_step_path
        import_destination_path
      end

      private

      def next_step_for_gb_to_ni
        return trade_remedies_path if trade_defence
        return duty_path if zero_mfn_duty

        trader_scheme_path
      end
    end
  end
end
