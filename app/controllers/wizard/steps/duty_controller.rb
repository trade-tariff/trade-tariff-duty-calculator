module Wizard
  module Steps
    class DutyController < BaseController
      def show
        @duty_options = DutyCalculator.new(user_session, filtered_commodity).result
        @gbp_to_eur_exchange_rate = Api::ExchangeRate.for('GBP').rate
      end
    end
  end
end
