module Api
  class AdditionalCode < Api::Base
    EXCISE_ADDITIONAL_CODE_TYPE_ID = 'X'.freeze

    attributes :id,
               :code,
               :description,
               :formatted_description

    def formatted_code
      return additional_code_id if excise?

      code
    end

    def additional_code_type
      code && code[0]
    end

    def additional_code_id
      code && code[1..]
    end

    def excise?
      additional_code_type == EXCISE_ADDITIONAL_CODE_TYPE_ID
    end
  end
end
