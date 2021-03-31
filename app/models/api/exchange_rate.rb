module Api
  class ExchangeRate < Api::Base
    DEFAULT_SERVICE_SOURCE = :xi

    attributes :id,
               :rate,
               :base_currency,
               :applicable_date

    def self.for(currency)
      build_collection(DEFAULT_SERVICE_SOURCE).find { |exchange_rate| exchange_rate.id == currency }
    end
  end
end
