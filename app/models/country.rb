class Country
  attr_reader :code

  def initialize(attributes)
    @attributes = attributes
  end

  def id
    @attributes.geographical_area_id
  end

  def name
    @attributes.description
  end

  def self.list(service = :uk)
    countries = response(service).data.map do |country|
      Country.new(country.attributes)
    end
    countries.sort_by(&:name)
  end

  def self.response(service)
    options = options(service)
    commodity = Uktt::Country.new(options)
    commodity.retrieve
    commodity.response
  end

  def self.options(service)
    OptionBuilder.new(service).call
  end
end
