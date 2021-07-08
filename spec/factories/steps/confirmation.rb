FactoryBot.define do
  factory :confirmation, class: 'Steps::Confirmation', parent: :step do
    transient { possible_attributes { {} } }
  end
end
