class ApplicableMeasureUnitMerger
  include CommodityHelper

  UNHANDLED_MEASURE_UNITS = %w[
    FC1X
  ].freeze

  def call
    return delta_measure_units if user_session.deltas_applicable?

    send("#{user_session.commodity_source}_measure_units")
  end

  private

  def delta_measure_units
    clean_unhandled_measure_units do
      uk_filtered_commodity.applicable_measure_units.merge(xi_filtered_commodity.applicable_measure_units)
    end
  end

  def uk_measure_units
    clean_unhandled_measure_units do
      uk_filtered_commodity.applicable_measure_units
    end
  end

  def xi_measure_units
    clean_unhandled_measure_units do
      xi_filtered_commodity.applicable_measure_units.merge(uk_filtered_commodity.applicable_excise_measure_units)
    end
  end

  def clean_unhandled_measure_units
    yield.tap do |units|
      UNHANDLED_MEASURE_UNITS.each do |unhandled_unit|
        units.delete(unhandled_unit)
      end
    end
  end

  def user_session
    UserSession.get
  end
end
