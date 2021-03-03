module Wizard
  module Steps
    class TraderScheme < Wizard::Steps::Base
      OPTIONS = [
        OpenStruct.new(id: 1, name: 'Yes, I am registered with the UK Trader Scheme'),
        OpenStruct.new(id: 0, name: 'No, I am not registered with the UK Trader Scheme'),
      ].freeze

      STEPS_TO_REMOVE_FROM_SESSION = %w[
        final_use
      ].freeze

      attribute :trader_scheme, :string

      validates :trader_scheme, presence: true

      def trader_scheme
        super || user_session.trader_scheme
      end

      def save
        user_session.trader_scheme = trader_scheme
      end

      def next_step_path(service_choice:, commodity_code:)
        # To be added on the ticket that creates the next step
      end

      def previous_step_path(service_choice:, commodity_code:)
        country_of_origin_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end
    end
  end
end
