FactoryBot.define do
  factory :order_number, class: 'Api::OrderNumber' do
    id { '058048' }
    number { '058048' }
    definition { attributes_for :definition }
  end
end
