# Helper for UK Internal Market Scheme
module UkimsHelper
  CUT_OFF_DATE = Date.new(2023, 9, 30)

  def uk_internal_market_scheme
    if after_cut_off_date?
      'UK Internal Market Scheme'
    else
      'UK Trader Scheme'
    end
  end

  def ukims_annual_turnover
    if after_cut_off_date?

      '£2,000,000'
    else
      '£500,000'
    end
  end

  def ukims_application_link
    if after_cut_off_date?

      'https://www.gov.uk/guidance/apply-for-authorisation-for-the-uk-internal-market-scheme-if-you-bring-goods-into-northern-ireland'
    else
      'https://www.gov.uk/guidance/apply-for-authorisation-for-the-uk-trader-scheme-if-you-bring-goods-into-northern-ireland-from-1-january-2021'
    end
  end

  def ukims_info_url
    if after_cut_off_date?
      'https://www.gov.uk/government/news/windsor-framework-unveiled-to-fix-problems-of-the-northern-ireland-protocol'
    else
      'https://www.gov.uk/guidance/apply-for-authorisation-for-the-uk-trader-scheme-if-you-bring-goods-into-northern-ireland'
    end
  end

  def explore_topic_title
    if after_cut_off_date?
      'Find out more about the Windsor Framework'
    else
      'Explore the topic'
    end
  end

  private

  def after_cut_off_date?
    return false unless user_session.import_date

    user_session.import_date >= CUT_OFF_DATE
  end
end
