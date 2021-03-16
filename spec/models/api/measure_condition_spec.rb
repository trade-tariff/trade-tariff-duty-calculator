RSpec.describe Api::MeasureCondition do
  it_behaves_like 'a resource that has attributes', condition_code: 'B',
                                                    condition: 'B: Presentation of a certificate/licence/document',
                                                    document_code: '',
                                                    requirement: nil,
                                                    action: 'The entry into free circulation is not allowed',
                                                    duty_expression: '',
                                                    condition_duty_amount: nil,
                                                    condition_monetary_unit_code: nil,
                                                    monetary_unit_abbreviation: nil,
                                                    condition_measurement_unit_code: nil,
                                                    condition_measurement_unit_qualifier_code: nil,
                                                    measure_condition_components: []
end
