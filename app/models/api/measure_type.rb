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
      '145' => ::DutyOptions::TariffPreference,
      '106' => ::DutyOptions::TariffPreference,
      '122' => ::DutyOptions::Quota::NonPreferential,
      '123' => ::DutyOptions::Quota::NonPreferentialEndUse,
      '143' => ::DutyOptions::Quota::Preferential,
      '146' => ::DutyOptions::Quota::PreferentialEndUse,
    }.freeze

    TYPE_ADDITIONAL_OPTION_MAPPING = {
      '551' => ::DutyOptions::AdditionalDuty::ProvisionalAntiDumping,
      '552' => ::DutyOptions::AdditionalDuty::DefinitiveAntiDumping,
      '553' => ::DutyOptions::AdditionalDuty::ProvisionalCountervailing,
      '554' => ::DutyOptions::AdditionalDuty::DefinitiveCountervailing,
      '695' => ::DutyOptions::AdditionalDuty::AdditionalDuties,
      '696' => ::DutyOptions::AdditionalDuty::AdditionalDutiesSafeguard,
    }.freeze

    EXCISE_MEASURE_TYPE_IDS = [
      '306', # "Excises"
    ].freeze

    SUPPORTED_MEASURE_TYPE_IDS = (TYPE_OPTION_MAPPING.keys + TYPE_ADDITIONAL_OPTION_MAPPING.keys).freeze

    attributes :id,
               :description,
               :national,
               :measure_type_series_id

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

    def additional_duty_option
      TYPE_ADDITIONAL_OPTION_MAPPING[id]
    end

    def additional_option?
      id.in?(TYPE_ADDITIONAL_OPTION_MAPPING.keys)
    end

    def self.supported_option_category?(category)
      TYPE_OPTION_MAPPING.values.any? { |option_klass| option_klass::CATEGORY == category }
    end
  end
end
