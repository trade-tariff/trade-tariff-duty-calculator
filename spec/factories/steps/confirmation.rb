FactoryBot.define do
  factory :confirmation, class: 'Wizard::Steps::Confirmation', parent: :step do
    transient { possible_attributes { {} } }
  end
end
