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
               :monetary_unit_abbreviation,
               :requirement

    has_many :measure_condition_components, MeasureConditionComponent

    enum :action_code, {
      stopping: [
        '08', # Declared subheading not allowed
      ],
      applicable: [
        '01', # Apply the amount of the action (see components)
        '24', # Entry into free circulation allowed
        '25', # Export allowed
        '26', # Import allowed
        '27', # Apply the mentioned duty
        '28', # Declared subheading allowed
        '29', # Import/export allowed after control
        '34', # Apply exemption/reduction of the anti-dumping duty
        '36', # Apply export refund
      ],
    }

    def document_code
      return attributes[:document_code] if attributes[:document_code].present?

      'None'
    end

    def certificate_description
      return "#{document_code} - #{attributes[:certificate_description]}" unless document_code == 'None'

      'None of the above'
    end

    def expresses_unit?
      (condition_measurement_unit_code || condition_monetary_unit_code).present?
    end

    def expresses_document?
      condition_code.in?(DOCUMENT_CONDITION_CODES)
    end
  end
end
