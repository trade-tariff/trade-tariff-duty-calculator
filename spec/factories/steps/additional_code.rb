FactoryBot.define do
  factory :additional_code, class: 'Steps::AdditionalCode', parent: :step do
    transient { possible_attributes { { measure_type_id: 'measure_type_id', additional_code_uk: 'additional_code_uk', additional_code_xi: 'additional_code_xi' } } }

    measure_type_id { '105' }
    additional_code_uk { '2300' }
    additional_code_xi { '2600' }
  end
end
