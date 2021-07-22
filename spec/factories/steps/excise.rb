FactoryBot.define do
  factory :excise, class: 'Steps::Excise', parent: :step do
    transient { possible_attributes { { measure_type_id: 'measure_type_id', additional_code: 'additional_code' } } }

    measure_type_id { '306' }
    additional_code { 'X444' }
  end
end
