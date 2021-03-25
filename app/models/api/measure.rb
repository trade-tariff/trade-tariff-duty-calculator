module Api
  class Measure < Api::Base
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

    def all_components
      # TODO: This needs to include measure condition components
      @all_components ||= measure_components
    end

    def evaluator_for(user_session)
      if ad_valorem?
        AdValoremExpressionEvaluator.new(ad_valorem_component, user_session.total_amount)
      end
    end

    def ad_valorem_component
      all_components.first
    end

    def ad_valorem?
      all_components.length == 1 &&
        ad_valorem_component.duty_expression_id == '01' &&
        ad_valorem_component.no_expresses_unit?
    end
  end
end
