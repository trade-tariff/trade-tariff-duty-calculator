module CommodityHelper
  def filtered_commodity(filter: default_filter)
    query = default_query.merge(filter)

    Api::Commodity.build(
      user_session.commodity_source,
      user_session.commodity_code,
      query,
    )
  end

  def commodity
    @commodity ||= Api::Commodity.build(
      user_session.commodity_source,
      user_session.commodity_code,
      default_query,
    )
  end

  def applicable_additional_codes
    @applicable_additional_codes ||= filtered_commodity.applicable_additional_codes
  end

  def applicable_vat_options
    @applicable_vat_options ||= filtered_commodity.applicable_vat_options
  end

  private

  def default_query
    { 'as_of' => as_of }
  end

  def default_filter
    { 'filter[geographical_area_id]' => country_of_origin_code }
  end

  def as_of
    return user_session.import_date.iso8601 if user_session.import_date.present?

    Time.zone.today.iso8601
  end

  def country_of_origin_code
    return user_session.other_country_of_origin if user_session.country_of_origin == 'OTHER'

    user_session.country_of_origin
  end
end
