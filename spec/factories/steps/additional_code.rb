FactoryBot.define do
  factory :additional_code, class: 'Wizard::Steps::AdditionalCode', parent: :step do
    transient { possible_attributes { { measure_type_id: 'measure_type_id', additional_code: 'additional_code' } } }

    measure_type_id { '105' }
    additional_code { '2300' }
  end
end
