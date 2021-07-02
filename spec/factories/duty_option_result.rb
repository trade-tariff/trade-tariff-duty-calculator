FactoryBot.define do
  factory :duty_option_result, class: 'Hash' do
    transient do
      measure_type_id { '103' }
    end

    key { DutyOptions::ThirdCountryTariff.id }
    footnote { I18n.t("measure_type_footnotes.#{measure_type_id}") }
    warning_text {}
    values {}
    value {}

    initialize_with do
      {
        evaluation: attributes.slice(:footnote, :warning_text, :values, :value),
        key: attributes[:key],
      }
    end
  end

  trait :third_country_tariff do
    key { DutyOptions::ThirdCountryTariff.id }
    measure_type_id { '103' }
    values {}
    value { 100 }
  end
end
