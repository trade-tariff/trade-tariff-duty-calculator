module Steps
  class DutyController < BaseController
    def show
      @duty_options = duty_options
      @gbp_to_eur_exchange_rate = Api::MonetaryExchangeRate.for('GBP').exchange_rate.round(4) unless user_session.import_into_gb?
    end

    private

    def duty_options
      return nil if user_session.no_duty_to_pay?
      return DutyCalculator.new(user_session, filtered_commodity).options unless user_session.deltas_applicable?

      RowToNiDutyCalculator.new(user_session, uk_options, xi_options).options if user_session.deltas_applicable?
    end

    def uk_options
      @uk_options ||= DutyCalculator.new(user_session, filtered_commodity(source: 'uk')).options
    end

    def xi_options
      @xi_options ||= DutyCalculator.new(user_session, filtered_commodity(source: 'xi')).options
    end
  end
end
