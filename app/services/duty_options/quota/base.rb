module DutyOptions
  module Quota
    class Base < DutyOptions::Base
      PRIORITY = 3

      def option
        super().merge(
          footnote: I18n.t("duty_calculations.options.footnote.#{self.class.id}"),
          order_number: measure.order_number.number,
        )
      end
    end
  end
end
