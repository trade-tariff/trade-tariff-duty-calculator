class MeasureUnitMerger
  include CommodityHelper

  def call
    uk_measure_units.merge(xi_measure_units) do |_key, uk_units, xi_units|
      uk_units['measure_sids'] += xi_units['measure_sids']

      uk_units
    end
  end

  private

  def xi_measure_units
    xi_filtered_commodity.applicable_measure_units
  end

  def uk_measure_units
    uk_filtered_commodity.applicable_measure_units
  end

  def user_session
    UserSession.get
  end
end
