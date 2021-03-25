class Table
  def initialize(measure, user_session, additional_duty_rows)
    @measure = measure
    @user_session = user_session
    @additional_duty_rows = additional_duty_rows
  end

  def option
    {
      warning_text: I18n.t('duty_calculations.options.mfn.warning_text'),
      values: option_values,
    }
  end

  protected

  attr_reader :measure, :user_session, :additional_duty_rows

  def measure_rows
    raise NotImplementedError
  end

  def valuation_row
    [
      I18n.t('duty_calculations.options.import_valuation'),
      I18n.t('duty_calculations.options.customs_value'),
      "£#{user_session.total_amount}",
    ]
  end

  def duty_totals_row
    [
      I18n.t('duty_calculations.options.duty_total_html').html_safe,
      nil,
      "£#{duty_totals}",
    ]
  end

  def duty_evaluation
    @duty_evaluation ||= measure.evaluator_for(user_session).call
  end

  def duty_totals
    additional_duty_values = @additional_duty_rows.map { |_, _, value| value }
    duty_values = [duty_evaluation[:value]]

    (additional_duty_values + duty_values).inject(:+)
  end

  def option_values
    table = [
      valuation_row,
    ]

    table.concat(measure_rows)
    table.concat(additional_duty_rows)

    table << duty_totals_row

    table
  end
end
