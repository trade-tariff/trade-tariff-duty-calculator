FactoryBot.define do
  factory :duty_option_result, class: 'Hash' do
    sequence(:measure_sid)

    transient do
      measure_type_id { '103' }
    end

    key { DutyOptions::ThirdCountryTariff.id }
    category { DutyOptions::ThirdCountryTariff::CATEGORY }
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
          :category,
        ),
        key: attributes[:key],
        priority: attributes[:priority],
      }
    end
  end

  trait :third_country_tariff do
    key { DutyOptions::ThirdCountryTariff.id }
    category { DutyOptions::ThirdCountryTariff::CATEGORY }
    priority { DutyOptions::ThirdCountryTariff::PRIORITY }
    measure_type_id { '103' }
  end

  trait :tariff_preference do
    key { DutyOptions::TariffPreference.id }
    category { DutyOptions::TariffPreference::CATEGORY }
    measure_type_id { '142' }
    priority { DutyOptions::TariffPreference::PRIORITY }
  end

  trait :suspension do
    key { DutyOptions::Suspension::Autonomous.id }
    category { DutyOptions::Suspension::Base::CATEGORY }
    measure_type_id { '112' }
    priority { DutyOptions::Suspension::Base::PRIORITY }
  end

  trait :quota do
    key { DutyOptions::Quota::NonPreferential.id }
    category { DutyOptions::Quota::Base::CATEGORY }
    measure_type_id { '122' }
    priority { DutyOptions::Quota::Base::PRIORITY }
    source { 'uk' }
  end

  trait :unhandled do
    key { :unhandled }
    category { :unhandled }
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
