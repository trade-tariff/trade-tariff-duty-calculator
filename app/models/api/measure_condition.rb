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

    # TODO: As we extend handling for more complex measure conditions with more complex actions we should extend this list with the ones under ACTION_CODES which will require more complex calculations
    APPLY_MEASURE_ACTION_CODES = [
      '01', # 'Apply the amount of the action (see components)'
      '24', # 'Entry into free circulation allowed'
      '25', # 'Export allowed'
      '26', # 'Import allowed'
      '27', # 'Apply the mentioned duty'
      '28', # 'Declared subheading allowed'
      '29', # 'Import/export allowed after control'
      '34', # 'Apply exemption/reduction of the anti-dumping duty'
      '36', # 'Apply export refund'
    ].freeze

    EXCLUDE_MEASURE_ACTION_CODES = [
      '04', # 'The entry into free circulation is not allowed'
      '05', # 'Export is not allowed'
      '06', # 'Import is not allowed'
      '07', # 'Measure not applicable'
      '08', # 'Declared subheading not allowed'
      '09', # 'Import/export not allowed after control'
      '16', # 'Export refund not applicable'
    ].freeze

    ACTION_CODES = [
      '02', # 'Apply the difference between the amount of the action (see components) and the price at import'
      '03', # 'Apply the difference between the amount of the action (see components) and CIF price'
      '10', # 'Declaration to be corrected - box 33, 37, 38, 41 or 46 incorrect'
      '11', # 'Apply the difference between the amount of the action (see components) and the free at frontier price before duty'
      '12', # 'Apply the difference between the amount of the action (see components) and the CIF price before duty'
      '13', # 'Apply the difference between the amount of the action (see components) and the CIF price augmented with the duty to be paid per tonne'
      '14', # 'The exemption/reduction of the anti-dumping duty is not applicable'
      '15', # 'Apply the difference between the amount of the action (see components) and the price augmented with the countervailing duty (3,8%)'
      '30', # 'Suspicious case'
    ] + APPLY_MEASURE_ACTION_CODES.dup + EXCLUDE_MEASURE_ACTION_CODES.dup

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

    def expresses_unit?
      (condition_measurement_unit_code || condition_monetary_unit_code).present?
    end

    def expresses_document?
      condition_code.in?(DOCUMENT_CONDITION_CODES)
    end

    def applicable?
      action_code.in?(APPLY_MEASURE_ACTION_CODES)
    end
  end
end
