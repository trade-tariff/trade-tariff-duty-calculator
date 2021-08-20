class ApplicableMeasureUnitMerger
  include CommodityHelper

  def call
    return delta_measure_units if user_session.deltas_applicable?

    send("#{user_session.commodity_source}_measure_units")
  end

  private

  def delta_measure_units
    uk_filtered_commodity.applicable_measure_units.merge(xi_filtered_commodity.applicable_measure_units)
  end

  def uk_measure_units
    uk_filtered_commodity.applicable_measure_units
  end

  def xi_measure_units
    xi_filtered_commodity.applicable_measure_units.merge(uk_filtered_commodity.applicable_excise_measure_units)
  end

  def user_session
    UserSession.get
  end
end
