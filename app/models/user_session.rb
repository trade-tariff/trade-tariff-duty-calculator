class UserSession
  attr_reader :session

  def initialize(session)
    @session = session
    @session['answers'] ||= {}
    @session['answers'][Wizard::Steps::AdditionalCode.id] ||= {}
  end

  def remove_step_ids(ids)
    ids.map { |id| session['answers'].delete(id) } unless ids.empty?
  end

  def import_date
    return if session['answers'][Wizard::Steps::ImportDate.id].blank?

    Date.parse(session['answers'][Wizard::Steps::ImportDate.id])
  end

  def import_date=(value)
    session['answers'][Wizard::Steps::ImportDate.id] = value
  end

  def import_destination
    session['answers'][Wizard::Steps::ImportDestination.id]
  end

  def import_destination=(value)
    session['answers'][Wizard::Steps::ImportDestination.id] = value
  end

  def country_of_origin
    session['answers'][Wizard::Steps::CountryOfOrigin.id]
  end

  def country_of_origin=(value)
    session['answers'][Wizard::Steps::CountryOfOrigin.id] = value
  end

  def trader_scheme
    session['answers'][Wizard::Steps::TraderScheme.id]
  end

  def trader_scheme=(value)
    session['answers'][Wizard::Steps::TraderScheme.id] = value
  end

  def final_use
    session['answers'][Wizard::Steps::FinalUse.id]
  end

  def final_use=(value)
    session['answers'][Wizard::Steps::FinalUse.id] = value
  end

  def certificate_of_origin
    session['answers'][Wizard::Steps::CertificateOfOrigin.id]
  end

  def certificate_of_origin=(value)
    session['answers'][Wizard::Steps::CertificateOfOrigin.id] = value
  end

  def planned_processing
    session['answers'][Wizard::Steps::PlannedProcessing.id]
  end

  def planned_processing=(value)
    session['answers'][Wizard::Steps::PlannedProcessing.id] = value
  end

  def trade_defence
    session['trade_defence']
  end

  def trade_defence=(value)
    session['trade_defence'] = value
  end

  def zero_mfn_duty
    session['zero_mfn_duty']
  end

  def zero_mfn_duty=(value)
    session['zero_mfn_duty'] = value
  end

  def customs_value
    session['answers'][Wizard::Steps::CustomsValue.id]
  end

  def customs_value=(values)
    session['answers'][Wizard::Steps::CustomsValue.id] = {
      'monetary_value' => values['monetary_value'],
      'shipping_cost' => values['shipping_cost'],
      'insurance_cost' => values['insurance_cost'],
    }
  end

  def additional_code=(value)
    session['answers'][Wizard::Steps::AdditionalCode.id].merge!(value)
  end

  def additional_code
    session['answers'][Wizard::Steps::AdditionalCode.id]
  end

  def measure_type_ids
    session['answers'][Wizard::Steps::AdditionalCode.id].keys
  end

  def commodity_source=(value)
    session['commodity_source'] = value
  end

  def commodity_source
    session['commodity_source']
  end

  def referred_service=(value)
    session['referred_service'] = value
  end

  def referred_service
    session['referred_service']
  end

  def commodity_code=(value)
    session['commodity_code'] = value
  end

  def commodity_code
    session['commodity_code']
  end

  def measure_amount=(values)
    session['answers'][Wizard::Steps::MeasureAmount.id] = values
  end

  def measure_amount
    session['answers'][Wizard::Steps::MeasureAmount.id] || {}
  end

  def monetary_value
    session['answers'][Wizard::Steps::CustomsValue.id].try(:[], 'monetary_value')
  end

  def shipping_cost
    session['answers'][Wizard::Steps::CustomsValue.id].try(:[], 'shipping_cost')
  end

  def insurance_cost
    session['answers'][Wizard::Steps::CustomsValue.id].try(:[], 'insurance_cost')
  end

  def ni_to_gb_route?
    import_destination == 'UK' && country_of_origin == 'XI'
  end

  def gb_to_ni_route?
    import_destination == 'XI' && country_of_origin == 'GB'
  end

  def eu_to_ni_route?
    import_destination == 'XI' && Api::GeographicalArea.eu_member?(country_of_origin)
  end

  def row_to_gb_route?
    import_destination == 'UK' && country_of_origin != 'XI'
  end

  def total_amount
    customs_value.values.map(&:to_f).reduce(:+)
  end

  def commodity_additional_code
    additional_code.values.join(', ')
  end
end
