class Commodity
  attr_reader :code

  def initialize(code:, service: :uk)
    @code = code
    @service = service
  end

  def description
    fetch.data.attributes.description
  end

  def fetch
    @fetch ||= begin
                 commodity = Uktt::Commodity.new(options)
                 commodity.retrieve
                 commodity.response
               end
  end

  private

  attr_reader :response, :service

  def options
    @options = OptionBuilder.new(service).call
      .merge(commodity_id: code)
  end
end
