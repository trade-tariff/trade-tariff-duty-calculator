module Api
  class MeasureType < Api::Base
    THIRD_COUNTRY = %w[103 105].freeze # 105 measure types are for end use Third Country duties. 103 are for everything else
    TARIFF_PREFERENCE = %w[142].freeze

    attributes :description,
               :national,
               :measure_type_series_id,
               :id

    enum :measure_type_series_id, {
      applicable_duty: 'C',
      anti_dumping_and_countervailing_duty: 'D',
      additional_duty: 'F',
      countervailing_charge_duty: 'J',
      unit_price_duty: 'M',
    }

    def third_country?
      id.in?(THIRD_COUNTRY)
    end

    def tariff_preference?
      id.in?(TARIFF_PREFERENCE)
    end
  end
end
