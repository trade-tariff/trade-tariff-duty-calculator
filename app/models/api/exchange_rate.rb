module Api
  class ExchangeRate < Api::Base
    attributes :id,
               :rate,
               :base_currency,
               :applicable_date
  end
end
