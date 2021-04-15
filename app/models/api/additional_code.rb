module Api
  class AdditionalCode < Api::Base
    DEFENSIVE_CODES = %w[A B C 8].freeze

    attributes :code,
               :description,
               :formatted_description

    def additional_code_type
      code && code[0]
    end

    def additional_code_id
      code && code[1..]
    end

    def company_defensive_code?
      additional_code_type.in?(DEFENSIVE_CODES)
    end

    def no_company_defensive_code?
      !company_defensive_code?
    end
  end
end
