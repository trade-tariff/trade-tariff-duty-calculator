FactoryBot.define do
  sequence(:goods_nomenclature_sid, &:to_s)

  factory :commodity, class: 'Api::Commodity' do
    transient do
      applicable_measure_units { {} }
      applicable_additional_codes { {} }
      applicable_vat_options do
        {
          'VATR' => 'VAT reduced rate 5% (5.0)',
          'VATZ' => 'VAT zero rate (0.0)',
          'VAT' => 'Value added tax (20.0)',
        }
      end
      trade_defence { false }
      zero_mfn_duty { false }
      source { 'uk' }
    end

    meta do
      {
        'duty_calculator' => {
          'applicable_measure_units' => applicable_measure_units,
          'applicable_additional_codes' => applicable_additional_codes,
          'applicable_vat_options' => applicable_vat_options,
          'trade_defence' => trade_defence,
          'zero_mfn_duty' => zero_mfn_duty,
          'source' => source,
        },
      }
    end

    id { generate(:goods_nomenclature_sid) }
    producline_suffix { '80' }
    number_indents { 4 }
    description { 'Cherry tomatoes' }
    goods_nomenclature_item_id { '0702000007' }
    bti_url {}
    formatted_description { 'Cherry tomatoes' }
    description_plain { 'Cherry tomatoes' }
    consigned { false }
    consigned_from {}
    basic_duty_rate { '<span>8.00</span> %' }
    meursing_code { false }
    declarable { true }
    footnotes { [] }
    section {}
    chapter {}
    heading {}
    ancestors {}

    import_measures { [attributes_for(:measure)] }
    export_measures { [] }

    trait :with_multiple_stopping_condition_measures do
      import_measures do
        [
          attributes_for(
            :measure,
            :third_country_tariff,
            :with_stopping_conditions,
          ),
          attributes_for(
            :measure,
            :third_country_tariff_authorised_use,
            :with_stopping_conditions,
          ),
        ]
      end
    end

    trait :with_measures do
      import_measures { [attributes_for(:measure, :third_country_tariff)] }
    end

    trait :without_measures do
      import_measures { [] }
    end

    trait :with_compound_measure_units do
      import_measures do
        [
          attributes_for(
            :measure,
            :third_country_tariff,
            :with_compound_measure_components,
          ),
        ]
      end

      applicable_measure_units do
        {
          'ASV' => { 'unit' => 'percent', 'multiplier' => nil },
          'HLT' => { 'unit' => 'litres', "multiplier": '0.01' },
        }
      end
    end

    trait :with_compound_measure_units_no_multiplier do
      import_measures do
        [
          attributes_for(
            :measure,
            :third_country_tariff,
            :with_compound_measure_components,
          ),
        ]
      end

      applicable_measure_units do
        {
          'ASV' => { 'unit' => 'percent' },
          'HLT' => { 'unit' => 'x 100 litres' },
        }
      end
    end

    trait :with_measure_units_with_multiplier do
      import_measures { [attributes_for(:measure, :third_country_tariff, :with_pounds_measure_unit_measure_component)] }

      applicable_measure_units { { 'DTN' => { 'unit' => 'kilogrammes', 'multiplier' => '0.01' } } }
    end

    trait :with_retail_price_measure_units do
      applicable_measure_units { { 'RET' => { 'unit' => '£', 'multiplier' => nil } } }
    end

    trait :with_euro_measure_unit_measure_component do
      import_measures { [attributes_for(:measure, :third_country_tariff, :with_euro_measure_unit_measure_component)] }

      applicable_measure_units { { 'DTN' => { 'unit' => 'x 100 kg', 'multiplier' => nil } } }
    end

    trait :with_pounds_measure_unit_measure_component do
      import_measures { [attributes_for(:measure, :third_country_tariff, :with_pounds_measure_unit_measure_component)] }

      applicable_measure_units { { 'DTN' => { 'unit' => 'x 100 kg', 'multiplier' => nil } } }
    end

    trait :with_condition_measure_units do
      import_measures { [attributes_for(:measure, :third_country_tariff, :with_condition_measure_units)] }

      applicable_measure_units { { 'DTN' => { 'unit' => 'x 100 kg', 'multiplier' => nil } } }
    end
  end
end
