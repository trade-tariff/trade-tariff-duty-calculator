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

  concerning :PlannedProcessingText do
    def commercial_processing_hint_text
      html_data = if after_cut_off_date?
                    <<-PARAGRAPH
          <ul>
            <li>the sale of <strong>food</strong> to end consumers in the UK</li>
            <li><strong>construction</strong>, where the processed goods form a permanent part of a structure that is constructed and located in Northern Ireland by the importer or one subsequent entity</li>
            <li>direct provision to the recipient of <strong>health or care services<strong> in Northern Ireland by the importer or one subsequent entity</li>
            <li><strong>not for profit</strong> activities in Northern Ireland by the importer or one subsequent entity, where there is no subsequent sale of the processed goods</li>
            <li>the final use of <strong>animal feed</strong> on premises located in Northern Ireland by the importer or one subsequent entity.</li>
          </ul>
                    PARAGRAPH

                  else
                    <<-PARAGRAPH
          <ul>
            <li>the sale of <strong>food</strong> to end consumers in the UK</li>
            <li><strong>construction</strong>, where the processed goods form a permanent part of a structure that is constructed and located in NI by the importer</li>
            <li>direct provision of <strong>health or care services</strong> by the importer in NI</li>
            <li><strong>not for profit</strong> activities in NI, where there is no subsequent sale of the processed good by the importer</li>
            <li>the final use of <strong>animal feed</strong> on premises located in NI by the importer.</li>
          </ul>
                    PARAGRAPH
                  end

      html_data.html_safe
    end
  end

  private

  def after_cut_off_date?
    return false unless user_session.import_date

    user_session.import_date >= CUT_OFF_DATE
  end
end
