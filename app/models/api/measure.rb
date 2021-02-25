module Api
  class Measure < Base
    has_many :measure_conditions, MeasureCondition
    has_many :measure_components, MeasureComponent

    has_one :measure_type, MeasureType
    has_one :geographical_area, GeographicalArea
    has_one :duty_expression, DutyExpression

    attributes :id,
               :origin,
               :additional_code,
               :effective_start_date,
               :effective_end_date,
               :import,
               :excise,
               :vat,
               :duty_expression,
               :measure_type,
               :legal_acts,
               :national_measurement_units,
               :geographical_area,
               :excluded_countries,
               :footnotes,
               :order_number
  end
end
