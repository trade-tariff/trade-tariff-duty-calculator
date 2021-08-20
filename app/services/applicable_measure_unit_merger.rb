class ApplicableMeasureUnitMerger
  include CommodityHelper

  def call
    return delta_measure_units if user_session.deltas_applicable?

    send("#{user_session.commodity_source}_measure_units")
  end

  private

  def delta_measure_units
    uk_filtered_commodity.applicable_measure_units.merge(xi_filtered_commodity.applicable_measure_units) do |_key, uk_units, xi_units|
      uk_units['component_ids'] += xi_units['component_ids']
      uk_units['condition_component_ids'] += xi_units['condition_component_ids']
      uk_units['component_ids'].uniq!
      uk_units['condition_component_ids'].uniq!

      uk_units
    end
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
