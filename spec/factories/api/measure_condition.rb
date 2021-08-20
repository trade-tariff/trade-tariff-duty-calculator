FactoryBot.define do
  sequence(:measure_condition_sid)

  factory :measure_condition, class: 'Api::MeasureCondition' do
    id { generate(:measure_condition_sid) }
    action {}
    action_code {}
    certificate_description {}
    condition {}
    condition_code {}
    condition_duty_amount {}
    condition_measurement_unit_code {}
    condition_measurement_unit_qualifier_code {}
    condition_monetary_unit_code {}
    document_code {}
    duty_expression { "<span>35.10</span> GBP / <abbr title='Hectokilogram'>100 kg</abbr>" }
    monetary_unit_abbreviation {}
    requirement {}
    measure_condition_components { [] }

    trait :with_trigger_measure_units do
      condition_duty_amount { 35.1 }
      condition_measurement_unit_code { 'DTN' }
      duty_expression { "<span>35.10</span> GBP / <abbr title='Hectokilogram'>100 kg</abbr>" }
    end

    trait :with_condition_components do
      measure_condition_components { [attributes_for(:measure_condition_component)] }
    end
  end
end
