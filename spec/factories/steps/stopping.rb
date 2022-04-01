FactoryBot.define do
  factory :stopping, class: 'Steps::Stopping', parent: :step do
    transient do
      possible_attributes { {} }
    end
  end
end
