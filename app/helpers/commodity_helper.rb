module CommodityHelper
  def filtered_commodity(filter: default_filter, source: user_session.commodity_source)
    commodity_source = source || user_session.commodity_source
    commodity_code = user_session.commodity_code
    query = default_query.merge(filter)

    commodity_context_service.call(commodity_source, commodity_code, query)
  end

  def commodity
    commodity_source = user_session.commodity_source
    commodity_code = user_session.commodity_code

    commodity_context_service.call(commodity_source, commodity_code, default_query)
  end

  def applicable_additional_codes
    @applicable_additional_codes ||= filtered_commodity.applicable_additional_codes
  end

  def applicable_vat_options
    @applicable_vat_options ||= filtered_commodity(source: 'uk').applicable_vat_options
  end

  def applicable_measure_units
    return filtered_commodity.applicable_measure_units unless user_session.deltas_applicable?

    uk_measure_units.merge(xi_measure_units)
  end

  def applicable_measure_unit_keys
    applicable_measure_units.keys.map(&:downcase)
  end

  private

  def commodity_context_service
    Thread.current[:commodity_context_service]
  end

  def default_filter
    { 'filter[geographical_area_id]' => country_of_origin_code }
  end

  def default_query
    { 'as_of' => (user_session.import_date || Time.zone.today).iso8601 }
  end

  def country_of_origin_code
    return user_session.other_country_of_origin if user_session.country_of_origin == 'OTHER'

    user_session.country_of_origin
  end

  def uk_measure_units
    filtered_commodity(source: 'uk').applicable_measure_units
  end

  def xi_measure_units
    filtered_commodity(source: 'xi').applicable_measure_units
  end
end
