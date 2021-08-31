module DutyOptions
  module Quota
    class Base < DutyOptions::Base
      PRIORITY = 3
      CATEGORY = :quota

      def call
        result = super
        result.order_number = measure.order_number.number
        result
      end
    end
  end
end
