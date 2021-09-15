FactoryBot.define do
  factory :prefill, class: 'Steps::Prefill', parent: :step do
    transient do
      possible_attributes { {} }
    end
  end
end
