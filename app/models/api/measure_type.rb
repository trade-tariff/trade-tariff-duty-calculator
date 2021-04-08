module Api
  class MeasureType < Api::Base
    TYPE_OPTION_MAPPING = {
      '103' => ::DutyOptions::ThirdCountryTariff,
      '105' => ::DutyOptions::ThirdCountryTariff,
      '112' => ::DutyOptions::Suspension::Autonomous,
      '115' => ::DutyOptions::Suspension::AutonomousEndUse,
      '117' => ::DutyOptions::Suspension::CertainCategoryGoods,
      '119' => ::DutyOptions::Suspension::Airworthiness,
      '142' => ::DutyOptions::TariffPreference,
    }.freeze

    attributes :description,
               :national,
               :measure_type_series_id,
               :id

    enum :id, {
      third_country: %w[103 105],
      tariff_preference: %w[142],
      autonomous_suspension: %w[112],
      autonomous_end_use_suspension: %w[115],
      certain_category_goods_suspension: %w[117],
      airworthiness_suspension: %w[119],
    }

    enum :measure_type_series_id, {
      applicable_duty: %w[C],
      anti_dumping_and_countervailing_duty: %w[D],
      additional_duty: %w[F],
      countervailing_charge_duty: %w[J],
      unit_price_duty: %w[M],
    }

    def option
      TYPE_OPTION_MAPPING[id]
    end
  end
end
