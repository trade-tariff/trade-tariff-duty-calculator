class ApplicableDocumentCodesService
  include CommodityHelper

  def initialize
    @applicable_document_codes = {}
  end

  def call
    return delta_measure_condition_documents if user_session.deltas_applicable?

    send("#{user_session.commodity_source}_measure_condition_documents")
  end

  private

  def delta_measure_condition_documents
    @applicable_document_codes['uk'] = surface_document_codes(uk_filtered_commodity)
    @applicable_document_codes['xi'] = surface_document_codes(xi_filtered_commodity)
    @applicable_document_codes
  end

  def uk_measure_condition_documents
    @applicable_document_codes['uk'] = surface_document_codes(uk_filtered_commodity)
    @applicable_document_codes
  end

  def xi_measure_condition_documents
    @applicable_document_codes['xi'] = surface_document_codes(xi_filtered_commodity)
    @applicable_document_codes
  end

  def surface_document_codes(commodity)
    commodity.applicable_measures.each_with_object({}) { |measure, acc|
      next unless measure.expresses_document?
      next if measure.document_codes.blank?

      acc[measure.measure_type.id] ||= []
      acc[measure.measure_type.id].concat(measure.document_codes)
    }.slice(
      *Api::MeasureType::SUPPORTED_MEASURE_TYPE_IDS,
    )
  end

  def user_session
    UserSession.get
  end
end
