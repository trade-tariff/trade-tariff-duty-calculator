class ApplicableMeasureUnitMerger
  include CommodityHelper

  UNHANDLED_MEASURE_UNITS = %w[
    FC1X
  ].freeze

  def initialize(dedupe: true)
    @dedupe = dedupe
  end

  def call
    return delta_measure_units if user_session.deltas_applicable?

    send("#{user_session.commodity_source}_measure_units")
  end

  private

  def delta_measure_units
    applicable_units =  uk_filtered_commodity.applicable_measure_units.merge(xi_filtered_commodity.applicable_measure_units)

    clean_and_dedup_measure_units(applicable_units)
  end

  def uk_measure_units
    applicable_units = uk_filtered_commodity.applicable_measure_units

    clean_and_dedup_measure_units(applicable_units)
  end

  def xi_measure_units
    applicable_units = xi_filtered_commodity.applicable_measure_units.merge(uk_filtered_commodity.applicable_excise_measure_units)

    clean_and_dedup_measure_units(applicable_units)
  end

  def clean_and_dedup_measure_units(applicable_units)
    if @dedupe
      applicable_units = applicable_units.uniq { |measurement_unit_code, measurement_unit_values|
        measurement_unit_values['coerced_measurement_unit_code'].presence || measurement_unit_code
      }.to_h
    end

    UNHANDLED_MEASURE_UNITS.each do |unhandled_unit|
      applicable_units.delete(unhandled_unit)
    end

    applicable_units
  end

  def user_session
    UserSession.get
  end
end
