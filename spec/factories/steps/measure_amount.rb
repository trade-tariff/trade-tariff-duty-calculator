FactoryBot.define do
  factory :measure_amount, class: 'Steps::MeasureAmount', parent: :step do
    transient do
      possible_attributes { { measure_amount: 'measure_amount', applicable_measure_units: 'applicable_measure_units' } }
      measure_amount { {} }
      applicable_measure_units do
        {
          'HLT' => {
            'measurement_unit_code' => 'HLT',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => 'hl',
            'unit_question' => 'What is the volume of the goods that you will be importing?',
            'unit_hint' => 'Enter the value in hectolitres (100 litres)',
            'unit' => 'x 100 litres',
            'component_ids' => [],
            'condition_component_ids' => [
              20_002_280,
            ],
          },
          'DTN' => {
            'measurement_unit_code' => 'DTN',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '100 kg',
            'unit_question' => 'What is the weight of the goods you will be importing?',
            'unit_hint' => 'Enter the value in decitonnes (100kg)',
            'unit' => 'x 100 kg',
            'component_ids' => [],
            'condition_component_ids' => [
              20_002_280,
            ],
          },
        }
      end
    end
  end
end
