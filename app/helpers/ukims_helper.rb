# Helper for UK Internal Market Scheme
module UkimsHelper
  CUT_OFF_DATE = Date.new(2023, 9, 30)

  def uk_internal_market_scheme
    if after_cut_off_date
      'UK Internal Market Scheme'
    else
      'UK Trader Scheme'
    end
  end

  def ukims_annual_turnover
    if after_cut_off_date

      '£2,000,000'
    else
      '£500,000'
    end
  end

  private


  def after_cut_off_date
    user_session.import_date >= CUT_OFF_DATE
  end
end
