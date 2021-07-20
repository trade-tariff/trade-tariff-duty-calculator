FactoryBot.define do
  factory :excise, class: 'Steps::Excise', parent: :step do
    transient { possible_attributes { { measure_type_id: 'measure_type_id', additional_code_uk: 'additional_code_uk', additional_code_xi: 'additional_code_xi' } } }

    measure_type_id { '306' }
    additional_code_uk { 'X444' }
    additional_code_xi { 'X111' }
  end
end
