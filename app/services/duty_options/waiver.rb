module DutyOptions
  class Waiver < DutyOptions::Base
    PRIORITY = 10

    def option
      {
        footnote: I18n.t('default_option_footnotes.waiver').html_safe,
        warning_text: nil,
        values: nil,
      }
    end
  end
end
