FactoryBot.define do
  factory :document_code, class: 'Steps::DocumentCode', parent: :step do
    transient { possible_attributes { { measure_type_id: 'measure_type_id', document_code_uk: 'document_code_uk', document_code_xi: 'document_code_xi' } } }

    measure_type_id { '117' }
    document_code_uk { 'C644' }
    document_code_xi { 'N851' }
  end
end
