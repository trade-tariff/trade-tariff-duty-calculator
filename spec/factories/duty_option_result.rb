FactoryBot.define do
  factory :duty_option_result, class: 'Hash' do
    sequence(:measure_sid)

    transient do
      measure_type_id { '103' }
    end

    key { DutyOptions::ThirdCountryTariff.id }
    footnote { I18n.t("measure_type_footnotes.#{measure_type_id}") }
    warning_text {}
    values {}
    value { 100 }
    source { 'uk' }

    initialize_with do
      {
        evaluation: attributes.slice(
          :footnote,
          :measure_sid,
          :source,
          :value,
          :values,
          :warning_text,
        ),
        key: attributes[:key],
        priority: attributes[:priority],
      }
    end
  end

  trait :third_country_tariff do
    key { DutyOptions::ThirdCountryTariff.id }
    measure_type_id { '103' }
    priority { DutyOptions::ThirdCountryTariff::PRIORITY }
  end

  trait :tariff_preference do
    key { DutyOptions::TariffPreference.id }
    measure_type_id { '142' }
    priority { DutyOptions::TariffPreference::PRIORITY }
  end

  trait :unhandled do
    key { :unhandled }
    measure_type_id { 'flibble' }
    priority { -500 }
  end

  trait :uk do
    source { 'uk' }
  end

  trait :xi do
    source { 'xi' }
  end
end
