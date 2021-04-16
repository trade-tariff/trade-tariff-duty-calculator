module Api
  class Measure < Api::Base
    has_many :measure_conditions, MeasureCondition
    has_many :measure_components, MeasureComponent

    has_one :measure_type, MeasureType
    has_one :geographical_area, GeographicalArea
    has_one :duty_expression, DutyExpression
    has_one :order_number, OrderNumber
    has_one :additional_code, AdditionalCode

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

    def evaluator_for(user_session)
      if ad_valorem?
        ExpressionEvaluators::AdValorem.new(self, user_session)
      elsif specific_duty?
        ExpressionEvaluators::MeasureUnit.new(self, user_session)
      else
        ExpressionEvaluators::Compound.new(self, user_session)
      end
    end

    def component
      @component ||= all_components.first
    end

    def all_components
      # TODO: This needs to include measure condition components
      @all_components ||= measure_components
    end

    def all_duties_zero?
      all_components.all? { |component| component.duty_amount.zero? }
    end

    private

    def ad_valorem?
      single_component? &&
        amount_or_percentage? &&
        component.no_specific_duty?
    end

    def specific_duty?
      single_component? &&
        amount_or_percentage? &&
        component.specific_duty?
    end

    def amount_or_percentage?
      component.duty_expression_id == '01'
    end

    def single_component?
      all_components.length == 1
    end
  end
end
