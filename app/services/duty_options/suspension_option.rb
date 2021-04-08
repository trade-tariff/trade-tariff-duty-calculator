module DutyOptions
  class SuspensionOption < DutyOptions::Base
    PRIORITY = 3

    def option
      super().merge(
        footnote: I18n.t("duty_calculations.options.footnote.#{self.class.id}"),
      )
    end
  end
end
