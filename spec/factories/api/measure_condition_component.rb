FactoryBot.define do
  sequence(:measure_condition_component_sid)

  factory :measure_condition_component, class: 'Api::MeasureConditionComponent' do
    transient do
      measure_condition_sid {}
    end

    id { "#{measure_condition_sid}-#{generate(:measure_condition_component_sid)}" }
    duty_expression_id {}
    duty_amount {}
    monetary_unit_code {}
    monetary_unit_abbreviation {}
    measurement_unit_code {}
    measurement_unit_qualifier_code {}
    duty_expression_description {}
    duty_expression_abbreviation {}

    trait :with_measure_units do
      duty_amount { 35.1 }
      measurement_unit_code { 'DTN' }
      duty_expression_abbreviation { '% or amount' }
      duty_expression_description { '%' }
      duty_expression_id { '01' }
    end
  end
end
