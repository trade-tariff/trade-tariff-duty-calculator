module CommodityHelper
  def filtered_commodity(filter: default_filter)
    query = default_query.merge(filter)

    Api::Commodity.build(
      user_session.commodity_source,
      user_session.commodity_code,
      query,
    )
  end

  def applicable_additional_codes
    @applicable_additional_codes ||= filtered_commodity.applicable_additional_codes
  end

  private

  def default_query
    { 'as_of' => user_session.import_date.iso8601 }
  end

  def default_filter
    { 'filter[geographical_area_id]' => user_session.country_of_origin }
  end
end
