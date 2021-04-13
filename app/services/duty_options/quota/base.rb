module DutyOptions
  module Quota
    class Base < DutyOptions::Base
      PRIORITY = 3

      def option
        super().merge(
          order_number: measure.order_number.number,
        )
      end
    end
  end
end
