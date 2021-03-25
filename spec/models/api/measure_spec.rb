RSpec.describe Api::Measure do
  it_behaves_like 'a resource that has attributes', measure_conditions: [],
                                                    measure_components: [],
                                                    id: -582_007,
                                                    origin: 'uk',
                                                    additional_code: nil,
                                                    effective_start_date: '2020-08-01T00:00:00.000Z',
                                                    effective_end_date: nil,
                                                    import: true,
                                                    excise: false,
                                                    vat: true,
                                                    legal_acts: [],
                                                    national_measurement_units: [],
                                                    excluded_countries: [],
                                                    footnotes: [],
                                                    order_number: nil
end
