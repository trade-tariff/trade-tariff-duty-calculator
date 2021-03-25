class ThirdCountryTariffTable < Table
  private

  def measure_rows
    [duty_calulation_row]
  end

  def duty_calulation_row
    [
      I18n.t('duty_calculations.options.import_duty_html', commodity_source: user_session.commodity_source).html_safe,
    ].concat(
      duty_evaluation.except(:value).values,
    )
  end
end
