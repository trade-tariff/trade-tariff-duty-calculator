class UserSession
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def remove_step_ids(ids)
    ids.map { |id| session.delete(id) } unless ids.empty?
  end

  def import_date
    return unless session.key?(Wizard::Steps::ImportDate.id)

    Date.parse(session[Wizard::Steps::ImportDate.id])
  end

  def import_date=(value)
    session[Wizard::Steps::ImportDate.id] = value
  end

  def import_destination
    session[Wizard::Steps::ImportDestination.id]
  end

  def import_destination=(value)
    session[Wizard::Steps::ImportDestination.id] = value
  end

  def country_of_origin
    session[Wizard::Steps::CountryOfOrigin.id]
  end

  def country_of_origin=(value)
    session[Wizard::Steps::CountryOfOrigin.id] = value
  end

  def trader_scheme
    session[Wizard::Steps::TraderScheme.id]
  end

  def trader_scheme=(value)
    session[Wizard::Steps::TraderScheme.id] = value
  end

  def final_use
    session[Wizard::Steps::FinalUse.id]
  end

  def final_use=(value)
    session[Wizard::Steps::FinalUse.id] = value
  end

  def certificate_of_origin
    session[Wizard::Steps::CertificateOfOrigin.id]
  end

  def certificate_of_origin=(value)
    session[Wizard::Steps::CertificateOfOrigin.id] = value
  end

  def planned_processing
    session[Wizard::Steps::PlannedProcessing.id]
  end

  def planned_processing=(value)
    session[Wizard::Steps::PlannedProcessing.id] = value
  end

  def customs_value=(values)
    session[Wizard::Steps::CustomsValue.id] = {
      'monetary_value' => values['monetary_value'],
      'shipping_cost' => values['shipping_cost'],
      'insurance_cost' => values['insurance_cost'],
    }
  end

  def measure_amount=(values)
    session[Wizard::Steps::MeasureAmount.id] = values
  end

  def measure_amount
    session[Wizard::Steps::MeasureAmount.id]
  end

  def monetary_value
    session[Wizard::Steps::CustomsValue.id].try(:[], 'monetary_value')
  end

  def shipping_cost
    session[Wizard::Steps::CustomsValue.id].try(:[], 'shipping_cost')
  end

  def insurance_cost
    session[Wizard::Steps::CustomsValue.id].try(:[], 'insurance_cost')
  end

  def ni_to_gb_route?
    import_destination == 'GB' && country_of_origin == 'XI'
  end

  def gb_to_ni_route?
    import_destination == 'XI' && country_of_origin == 'GB'
  end

  def eu_to_ni_route?
    import_destination == 'XI' && Api::GeographicalArea.eu_member?(country_of_origin)
  end
end
