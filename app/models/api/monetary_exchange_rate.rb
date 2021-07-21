module Api
  class MonetaryExchangeRate < Api::Base
    attributes :id,
               :child_monetary_unit_code,
               :exchange_rate,
               :operation_date,
               :validity_start_date

    def self.for(currency)
      monetary_exchange_rates = build_collection(:xi).select do |monetary_exchange_rate|
        monetary_exchange_rate.child_monetary_unit_code == currency.upcase
      end

      monetary_exchange_rates.max_by(&:validity_start_date)
    end

    def exchange_rate
      super.to_f
    end
  end
end
