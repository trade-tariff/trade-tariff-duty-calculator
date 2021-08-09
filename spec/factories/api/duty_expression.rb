FactoryBot.define do
  sequence(:duty_expression_id) { |id| "#{id}-duty-expression" }

  factory :duty_expression, class: 'Api::GeographicalArea' do
    id { generate(:duty_expression_id) }
    base { '144.10 GBP / 1000 kg/biodiesel' }
    formatted_base { "<span>144.10</span> GBP / <abbr title='Tonne'>1000 kg/biodiesel</abbr>" }
  end
end
