RSpec.describe Api::MeasureComponent do
  it_behaves_like 'a resource that has attributes', duty_expression_id: '01',
                                                    duty_amount: 0.0,
                                                    monetary_unit_code: nil,
                                                    monetary_unit_abbreviation: nil,
                                                    measurement_unit_code: nil,
                                                    duty_expression_description: '% or amount',
                                                    duty_expression_abbreviation: '%',
                                                    measurement_unit_qualifier_code: nil
end
