module CommodityHelper
  def filtered_commodity(filter: default_filter, source: user_session.commodity_source)
    commodity_source = source || user_session.commodity_source
    commodity_code = user_session.commodity_code
    query = default_query.merge(filter)

    commodity_context_service.call(commodity_source, commodity_code, query)
  end

  def uk_filtered_commodity
    filtered_commodity(source: 'uk')
  end

  def xi_filtered_commodity
    filtered_commodity(source: 'xi')
  end

  def commodity
    commodity_source = user_session.commodity_source
    commodity_code = user_session.commodity_code

    commodity_context_service.call(commodity_source, commodity_code, default_query)
  end

  def applicable_additional_codes
    @applicable_additional_codes ||=
      {}.tap do |additional_codes|
        if user_session.deltas_applicable?
          additional_codes['uk'] = uk_filtered_commodity.applicable_additional_codes.slice(
            *Api::MeasureType::ADDITIONAL_CODE_MEASURE_TYPE_IDS,
          )

          additional_codes['xi'] = xi_filtered_commodity.applicable_additional_codes.slice(
            *Api::MeasureType::ADDITIONAL_CODE_MEASURE_TYPE_IDS,
          )
        else
          additional_codes[user_session.commodity_source] = filtered_commodity.applicable_additional_codes.slice(
            *Api::MeasureType::ADDITIONAL_CODE_MEASURE_TYPE_IDS,
          )
        end
      end
  end

  def applicable_excise_additional_codes
    @applicable_excise_additional_codes ||= uk_filtered_commodity.applicable_additional_codes.slice(
      *Api::MeasureType::EXCISE_MEASURE_TYPE_IDS,
    )
  end

  def applicable_document_codes
    @applicable_document_codes ||=
      {}.tap do |applicable_document_codes|
        if user_session.deltas_applicable?
          applicable_document_codes['uk'] = surface_document_codes(commodity: uk_filtered_commodity)
          applicable_document_codes['xi'] = surface_document_codes(commodity: xi_filtered_commodity)
        else
          applicable_document_codes[user_session.commodity_source] = surface_document_codes
        end
      end
  end

  def applicable_document_codes?
    applicable_document_codes.values.any?(&:present?)
  end

  def applicable_additional_codes?
    applicable_additional_codes.values.any?(&:present?)
  end

  def applicable_excise_additional_codes?
    applicable_excise_additional_codes.values.any?(&:present?)
  end

  def applicable_measure_type_ids
    applicable_additional_codes.flat_map { |_service, additional_codes| additional_codes.keys }.uniq
  end

  def document_codes_applicable_measure_type_ids
    applicable_document_codes.flat_map { |_service, applicable_document_codes| applicable_document_codes.keys }.uniq
  end

  def applicable_excise_measure_type_ids
    @applicable_excise_measure_type_ids ||= applicable_excise_additional_codes.keys
  end

  def applicable_vat_options
    @applicable_vat_options ||= uk_filtered_commodity.applicable_vat_options
  end

  def applicable_measure_units
    ApplicableMeasureUnitMerger.new.call
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

  def surface_document_codes(commodity: filtered_commodity)
    commodity.applicable_measures.each_with_object({}) { |measure, acc|
      next unless measure.expresses_document?
      next if measure.document_codes.blank?

      acc[measure.measure_type.id] ||= []
      acc[measure.measure_type.id].concat(measure.document_codes)
    }.slice(
      *Api::MeasureType::SUPPORTED_MEASURE_TYPE_IDS,
    )
  end
end
