FactoryBot.define do
  factory :measure_component, class: 'Api::MeasureComponent' do
    id {}
    duty_expression_id {}
    duty_amount {}
    duty_expression_description {}
    duty_expression_abbreviation {}
    monetary_unit_code {}
    monetary_unit_abbreviation {}
    measurement_unit_code {}
    measurement_unit_qualifier_code {}
  end
end
