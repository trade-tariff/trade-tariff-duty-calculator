FactoryBot.define do
  factory :trader_scheme, class: 'Wizard::Steps::TraderScheme', parent: :step do
    transient do
      possible_attributes { { trader_scheme: 'trader_scheme' } }
    end

    trader_scheme { '' }
  end
end
