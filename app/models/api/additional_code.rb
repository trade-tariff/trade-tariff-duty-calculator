module Api
  class AdditionalCode < Api::Base
    attributes :code,
               :description,
               :formatted_description

    def additional_code_type
      code && code[0]
    end

    def additional_code_id
      code && code[1..]
    end
  end
end
