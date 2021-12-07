FactoryBot.define do
  sequence(:measure_component_sid)

  factory :measure_component, class: 'Api::MeasureComponent' do
    id { generate(:measure_component_sid) }
    duty_expression_id {}
    duty_amount {}
    duty_expression_description {}
    duty_expression_abbreviation {}
    monetary_unit_code {}
    monetary_unit_abbreviation {}
    measurement_unit_code {}
    measurement_unit_qualifier_code {}

    trait :ad_valorem do
      duty_amount { 35.1 }
      duty_expression_abbreviation { '% or amount' }
      duty_expression_description { '%' }
      duty_expression_id { '01' }
    end

    trait :with_measure_units do
      duty_amount { 35.1 }
      measurement_unit_code { 'DTN' }
      duty_expression_abbreviation { '% or amount' }
      duty_expression_description { '%' }
      duty_expression_id { '01' }
    end

    trait :pounds do
      monetary_unit_code { 'GBP' }
    end

    trait :euros do
      monetary_unit_code { 'EUR' }
    end

    trait :single_measure_unit do
      measurement_unit_code { 'DTN' }
      measurement_unit_qualifier_code {}
    end

    trait :compound_measure_unit do
      measurement_unit_code { 'ASV' }
      measurement_unit_qualifier_code { 'X' }
    end

    trait :with_retail_price_measure_units do
      duty_amount { 16.5 }
      measurement_unit_code { 'RET' }
      duty_expression_abbreviation { '% or amount' }
      duty_expression_description { '%' }
      duty_expression_id { '01' }
    end
  end
end
