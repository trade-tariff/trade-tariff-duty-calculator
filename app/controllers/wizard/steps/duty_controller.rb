module Wizard
  module Steps
    class DutyController < BaseController
      def show
        @duty_options = DutyCalculator.new(user_session, filtered_commodity).result
        @gbp_to_eur_exchange_rate = Api::ExchangeRate.for('GBP').rate.round(4) unless import_into_gb?
      end

      private

      def import_into_gb?
        user_session.import_destination == 'UK'
      end
    end
  end
end
