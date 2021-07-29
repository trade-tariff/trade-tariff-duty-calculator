module Api
  class MeasureCondition < Api::Base
    DOCUMENT_CONDITION_CODES = [
      'B', # Presentation of a certificate/licence/document'
      'H', # Presentation of a certificate/licence/document'
      'E', # The quantity or the price per unit declared, as appropriate, is equal or less than the specified maximum, or presentation of the required document'
      'A', # Presentation of an anti-dumping/countervailing document'
      'C', # Presentation of a certificate/licence/document'
      'I', # The quantity or the price per unit declared, as appropriate, is equal or less than the specified maximum, or presentation of the required document'
    ].freeze

    attributes :id,
               :action,
               :action_code,
               :condition,
               :condition_code,
               :condition_duty_amount,
               :condition_measurement_unit_code,
               :condition_measurement_unit_qualifier_code,
               :condition_monetary_unit_code,
               :document_code,
               :certificate_description,
               :duty_expression,
               :measure_condition_components,
               :monetary_unit_abbreviation,
               :requirement

    def expresses_unit?
      (condition_measurement_unit_code || condition_monetary_unit_code).present?
    end

    def expresses_document?
      condition_code.in?(DOCUMENT_CONDITION_CODES)
    end
  end
end
