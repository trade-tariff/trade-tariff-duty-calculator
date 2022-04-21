FactoryBot.define do
  sequence(:measure_condition_sid, &:to_s)

  factory :measure_condition, class: 'Api::MeasureCondition' do
    id { generate(:measure_condition_sid) }
    action {}
    action_code {}
    certificate_description {}
    condition {}
    condition_code {}
    condition_duty_amount {}
    condition_measurement_unit_code {}
    condition_measurement_unit_qualifier_code {}
    condition_monetary_unit_code {}
    document_code {}
    duty_expression { "<span>35.10</span> GBP / <abbr title='Hectokilogram'>100 kg</abbr>" }
    monetary_unit_abbreviation {}
    requirement {}
    measure_condition_components { [] }

    trait :with_measure_units do
      condition_duty_amount { 35.1 }
      condition_measurement_unit_code { 'DTN' }
      duty_expression { "<span>35.10</span> GBP / <abbr title='Hectokilogram'>100 kg</abbr>" }

      measure_condition_components do
        [
          attributes_for(
            :measure_condition_component,
            :with_measure_units,
            measure_condition_sid: id,
          ),
        ]
      end
    end

    trait :stopping_negative do
      action { 'Declared subheading not allowed' }
      action_code { '08' }
      certificate_description {}
      condition { 'B: Presentation of a certificate/licence/document' }
      condition_code { 'B' }
      condition_duty_amount {}
      condition_measurement_unit_code {}
      condition_measurement_unit_qualifier_code {}
      condition_monetary_unit_code {}
      document_code { '' }
      duty_expression { '' }
      monetary_unit_abbreviation {}
      requirement {}
      measure_condition_class { 'negative' }
    end

    trait :stopping_document do
      action { 'Apply the mentioned duty' }
      action_code { '27' }
      certificate_description { 'EUS - Authorisation for the use of end use procedure (Column 8c, Annex A of Delegated Regulation (EU) 2015/2446)' }
      condition { 'B: Presentation of a certificate/licence/document' }
      condition_code { 'B' }
      condition_duty_amount {}
      condition_measurement_unit_code {}
      condition_measurement_unit_qualifier_code {}
      condition_monetary_unit_code {}
      document_code { 'N990' }
      duty_expression { '' }
      monetary_unit_abbreviation {}
      requirement { 'UN/EDIFACT certificates: EUS - Authorisation for the use of end use procedure (Column 8c, Annex A of Delegated Regulation (EU) 2015/2446)' }
      measure_condition_class { 'document' }
    end
  end
end
