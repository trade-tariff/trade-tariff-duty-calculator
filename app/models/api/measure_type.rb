module Api
  class MeasureType < Api::Base
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
  end
end
