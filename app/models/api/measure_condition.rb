module Api
  class MeasureCondition < Base
    attributes :condition_code,
               :condition,
               :document_code,
               :requirement,
               :action,
               :duty_expression,
               :condition_duty_amount,
               :condition_monetary_unit_code,
               :monetary_unit_abbreviation,
               :condition_measurement_unit_code,
               :condition_measurement_unit_qualifier_code,
               :measure_condition_components
  end
end
