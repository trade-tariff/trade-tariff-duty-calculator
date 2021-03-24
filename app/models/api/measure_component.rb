module Api
  class MeasureComponent < Api::Base
    attributes :duty_expression_id,
               :duty_amount,
               :duty_expression_description,
               :duty_expression_abbreviation,
               :monetary_unit_code,
               :monetary_unit_abbreviation,
               :measurement_unit_code,
               :measurement_unit_qualifier_code

    def expresses_unit?
      monetary_unit_code || measurement_unit_code
    end

    def no_expresses_unit?
      !expresses_unit?
    end
  end
end
