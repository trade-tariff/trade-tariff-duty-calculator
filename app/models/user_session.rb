class UserSession
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def remove_step_ids(ids)
    ids.map { |id| session.delete(id) } unless ids.empty?
  end

  def import_date
    return unless session.key?(Wizard::Steps::ImportDate::STEP_ID)

    Date.parse(session[Wizard::Steps::ImportDate::STEP_ID])
  end

  def import_date=(value)
    session[Wizard::Steps::ImportDate::STEP_ID] = value
  end

  def import_destination
    session[Wizard::Steps::ImportDestination::STEP_ID]
  end

  def import_destination=(value)
    session[Wizard::Steps::ImportDestination::STEP_ID] = value
  end

  def country_of_origin
    session[Wizard::Steps::CountryOfOrigin::STEP_ID]
  end

  def country_of_origin=(value)
    session[Wizard::Steps::CountryOfOrigin::STEP_ID] = value
  end

  def trader_scheme
    session[Wizard::Steps::TraderScheme::STEP_ID]
  end

  def trader_scheme=(value)
    session[Wizard::Steps::TraderScheme::STEP_ID] = value
  end

  def customs_value=(values)
    session[Wizard::Steps::CustomsValue::STEP_ID] = {
      'monetary_value' => values['monetary_value'],
      'shipping_cost' => values['shipping_cost'],
      'insurance_cost' => values['insurance_cost'],
    }
  end

  def monetary_value
    session[Wizard::Steps::CustomsValue::STEP_ID].try(:[], 'monetary_value')
  end

  def shipping_cost
    session[Wizard::Steps::CustomsValue::STEP_ID].try(:[], 'shipping_cost')
  end

  def insurance_cost
    session[Wizard::Steps::CustomsValue::STEP_ID].try(:[], 'insurance_cost')
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
