module DutyOptions
  class ThirdCountryTariff < DutyOptions::Base
    PRIORITY = 1
    CATEGORY = :third_country_tariff

    def option
      super().merge(
        warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
      )
    end
  end
end
