class Commodity
  attr_reader :code

  def initialize(code:, service: :uk)
    @code = code
    @service = service
  end

  def description
    response.data.attributes.description.html_safe
  end

  def response
    @response ||= begin
      commodity = Uktt::Commodity.new(options)
      commodity.retrieve
      commodity.response
    end
  end

  private

  attr_reader :service

  def options
    OptionBuilder.new(service).call
      .merge(commodity_id: code)
  end
end
