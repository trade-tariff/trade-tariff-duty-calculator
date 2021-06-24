module Wizard
  module Steps
    class DutyController < BaseController
      def show
        @duty_options = nominated_duty_options
        @gbp_to_eur_exchange_rate = Api::ExchangeRate.for('GBP').rate.round(4) unless import_into_gb?
      end

      private

      def import_into_gb?
        user_session.import_destination == 'UK'
      end

      def nominated_duty_options
        return RowToNiDutyCalculator.new(user_session).result if user_session.row_to_ni_route?

        DutyCalculator.new(user_session, filtered_commodity).result
      end
    end
  end
end
