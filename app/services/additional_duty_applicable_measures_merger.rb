class AdditionalDutyApplicableMeasuresMerger
  include CommodityHelper

  def call
    send("#{user_session.commodity_source}_applicable_measures")
  end

  private

  def xi_applicable_measures
    filtered_commodity.applicable_measures.select(&:applicable?).concat(uk_filtered_commodity.excise_measures)
  end

  def uk_applicable_measures
    filtered_commodity.applicable_measures.select(&:applicable?)
  end

  def user_session
    UserSession.get
  end
end
