module Wizard
  module Steps
    class DutyController < BaseController
      def show
        @duty_options = duty_options
        @gbp_to_eur_exchange_rate = Api::ExchangeRate.for('GBP').rate.round(4) unless user_session.import_into_gb?
      end

      private

      def duty_options
        return nil if user_session.no_duty_to_pay?
        return DutyCalculator.new(user_session, filtered_commodity).options unless user_session.deltas_applicable?

        RowToNiDutyCalculator.new(user_session).options if user_session.deltas_applicable?
      end

    end
  end
end
