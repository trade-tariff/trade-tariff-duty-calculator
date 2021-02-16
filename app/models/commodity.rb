class Commodity
  def initialize(code:, service: :uk)
    @code = code
    @service = service
  end

  def description
    fetch.data.attributes.description
  end

  private

  attr_reader :response, :code, :service

  def fetch
    @fetch ||= begin
                 commodity = Uktt::Commodity.new(options)
                 commodity.retrieve
                 commodity.response
               end
  end

  def options
    @options = OptionBuilder.new(service).call
      .merge(commodity_id: code)
  end
end
