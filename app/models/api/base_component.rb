module Api
  class BaseComponent < Api::Base
    CONJUNCTION_OPERATORS = %w[MAX MIN].freeze
    MATHEMATICAL_OPERATORS = %w[+ -].freeze

    attributes :id,
               :duty_expression_id,
               :duty_amount,
               :duty_expression_description,
               :duty_expression_abbreviation,
               :monetary_unit_code,
               :monetary_unit_abbreviation,
               :measurement_unit_code,
               :measurement_unit_qualifier_code

    enum :measurement_unit_code, {
      retail_price: %w[RET],
    }

    enum :duty_expression_id, {
      amount_or_percentage: %w[01 04 19 20],
    }

    def ad_valorem?
      no_specific_duty?
    end

    def specific_duty?
      measurement_unit_code
    end

    def no_specific_duty?
      !specific_duty?
    end

    def unit
      return nil if measurement_unit_code.blank?

      "#{measurement_unit_code}#{measurement_unit_qualifier_code}"
    end

    def conjunction_operator?
      duty_expression_abbreviation.in?(CONJUNCTION_OPERATORS)
    end

    def operator
      duty_expression_abbreviation
    end
  end
end
