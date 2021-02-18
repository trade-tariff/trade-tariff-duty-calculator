class Country
  attr_reader :code

  def initialize(service: :uk)
    @service = service
  end

  def list
    @formatted_countries ||= response.data.map { |country|
      country.attributes.description
    }.sort
  end

  def response
    @response ||= begin
                    commodity = Uktt::Country.new(options)
                    commodity.retrieve
                    commodity.response
                  end
  end

  private

  attr_reader :service

  def options
    OptionBuilder.new(service).call
  end
end
