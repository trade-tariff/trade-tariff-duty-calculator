module Api
  class MeasureComponent < Base
    attributes :duty_expression_id,
               :duty_amount,
               :monetary_unit_code,
               :monetary_unit_abbreviation,
               :measurement_unit_code,
               :duty_expression_description,
               :duty_expression_abbreviation,
               :measurement_unit_qualifier_code
  end
end
