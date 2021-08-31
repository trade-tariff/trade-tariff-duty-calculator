RSpec.describe DutyOptionResult do
  it_behaves_like 'a resource that has attributes',
                  type: 'tariff_preference',
                  category: :tariff_preference,
                  values: [],
                  value: 0.0,
                  footnote: '',
                  measure_sid: 3_822_192,
                  source: 'uk',
                  priority: 2,
                  warning_text: nil,
                  order_number: nil,
                  geographical_area_description: 'United Kingdom (excluding Northern Ireland)'
end
