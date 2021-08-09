FactoryBot.define do
  sequence(:additional_code_sid)

  factory :api_additional_code, class: 'Api::AdditionalCode' do
    id { generate(:additional_code_sid) }
    code {}
    description {}
    formatted_description {}
  end

  trait :vatz do
    code { 'VATZ' }
    description { 'VAT zero rate' }
    formatted_description { 'VAT zero rate' }
  end

  trait :company do
    code { 'C490' }
    description { 'COFCO International Argentina S.A.' }
    formatted_description { 'COFCO International Argentina S.A.' }
  end

  trait :excise do
    code { 'X99A' }
    description { 'CLIMATE CHANGE LEVY (CCL), 990, solid' }
    formatted_description { 'CLIMATE CHANGE LEVY (CCL), 990, solid' }
  end
end
