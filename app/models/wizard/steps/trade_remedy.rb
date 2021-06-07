module Wizard
  module Steps
    class TradeRemedy < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      def next_step_path
        customs_value_path
      end

      def previous_step_path
        return country_of_origin_path if user_session.gb_to_ni_route?

        previous_step_for_row_to_ni
      end

      private

      def previous_step_for_row_to_ni
        return country_of_origin_path if user_session.trade_defence
        return trader_scheme_path if user_session.trader_scheme == 'no'
        return final_use_path if user_session.final_use == 'no'
        return planned_processing_path unless user_session.planned_processing == 'commercial_purposes'

        # TODO: We will need to add a route here for acceptable processing when that stop page is available
      end
    end
  end
end
