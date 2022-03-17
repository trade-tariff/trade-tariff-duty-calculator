FactoryBot.define do
  factory :rules_of_origin_rule, class: 'Api::RulesOfOrigin::Rule' do
    heading { 'Chapter&nbsp;7' }
    description { 'Edible vegetables and certain roots and tubers' }
    rule { 'Manufacture in which all the materials of Chapter 7 used are wholly obtained{{WO}}' }
    alternate_rule { '' }
  end
end
