class UserSession
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def remove_keys_after(key)
    keys_to_remove = session.keys.map(&:to_i).uniq.select { |k| k > key }

    return if keys_to_remove.empty?

    session.delete(*keys_to_remove)
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

  def geographical_area_id
    session[Wizard::Steps::CountryOfOrigin::STEP_ID]
  end

  def geographical_area_id=(value)
    session[Wizard::Steps::CountryOfOrigin::STEP_ID] = value
  end

  def ni_to_gb_route?
    import_destination == 'GB' && geographical_area_id == 'XI'
  end

  def eu_to_ni_route?
    import_destination == 'XI' && Country.eu_member?(geographical_area_id)
  end
end
