class ThirdCountryTariffTable < Table
  private

  def measure_rows
    row = [
      "Import duty<br><span class=\"govuk-green govuk-body-xs\"> Third country duty (#{user_session.commodity_source.upcase})</span>".html_safe,
    ]

    row.concat(duty_evaluation.except(:value).values)

    [row]
  end
end
