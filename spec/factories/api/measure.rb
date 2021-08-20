FactoryBot.define do
  sequence(:measure_sid)

  factory :measure, class: 'Api::Measure' do
    transient do
      source { 'uk' }
    end

    id { generate(:measure_sid) }
    effective_end_date {}
    effective_start_date {}
    excise { false }
    excluded_countries {}
    footnotes {}
    import {}
    legal_acts {}
    national_measurement_units {}
    origin {}
    reduction_indicator {}
    vat { false }

    measure_type         { attributes_for :measure_type }
    geographical_area    { attributes_for :geographical_area }
    duty_expression      { attributes_for :duty_expression }
    order_number         { attributes_for :order_number }
    additional_code      {}
    suspension_legal_act {}

    measure_components { [] }
    measure_conditions { [] }

    initialize_with do
      meta = { 'meta' => { 'duty_calculator' => { 'source' => source } } }
      attributes = attribute_lists.first(&:non_ignored).each_with_object({}) do |dynamic_attribute, acc|
        acc[dynamic_attribute.name] = public_send(dynamic_attribute.name)
      end

      attributes = attributes.except(:source).merge(meta)

      new(attributes)
    end

    trait :autonomous do
      measure_type { attributes_for :measure_type, :autonomous }
    end

    trait :autonomous_end_use do
      measure_type { attributes_for :measure_type, :autonomous_end_use }
    end

    trait :certain_category_goods do
      measure_type { attributes_for :measure_type, :certain_category_goods }
    end

    trait :airworthiness do
      measure_type { attributes_for :measure_type, :airworthiness }
    end

    trait :non_preferential do
      measure_type { attributes_for :measure_type, :non_preferential }
    end

    trait :non_preferential_end_use do
      measure_type { attributes_for :measure_type, :non_preferential_end_use }
    end

    trait :tariff_preference do
      measure_type { attributes_for :measure_type, :tariff_preference }
    end

    trait :preferential do
      measure_type { attributes_for :measure_type, :preferential }
    end

    trait :preferential_end_use do
      measure_type { attributes_for :measure_type, :preferential_end_use }
    end

    trait :vat do
      measure_type { attributes_for :measure_type, :vat }
      vat { true }
    end

    trait :excise do
      measure_type { attributes_for :measure_type, :excise }
      excise { true }
    end

    trait :provisional_anti_dumping do
      measure_type { attributes_for :measure_type, :provisional_anti_dumping }
    end

    trait :definitive_anti_dumping do
      measure_type { attributes_for :measure_type, :definitive_anti_dumping }
    end

    trait :provisional_countervailing do
      measure_type { attributes_for :measure_type, :provisional_countervailing }
    end

    trait :definitive_countervailing do
      measure_type { attributes_for :measure_type, :definitive_countervailing }
    end

    trait :additional_duties do
      measure_type { attributes_for :measure_type, :additional_duties }
    end

    trait :additional_duties_safeguard do
      measure_type { attributes_for :measure_type, :additional_duties_safeguard }
    end

    trait :third_country_tariff do
      measure_type { attributes_for :measure_type, :third_country }
    end

    trait :tariff_preference do
      measure_type { attributes_for :measure_type, :tariff_preference }
    end

    trait :provisional_anti_dumping do
      measure_type { attributes_for :measure_type, :provisional_anti_dumping }
    end

    trait :with_measure_components do
      measure_components { [attributes_for(:measure_component)] }
    end

    trait :with_measure_conditions_with_components do
      measure_conditions { [attributes_for(:measure_condition, :with_condition_components)] }
    end
  end
end
