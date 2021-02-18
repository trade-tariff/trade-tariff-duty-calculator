class OptionBuilder
  def initialize(service, code)
    @service = service
    @code = code
  end

  def call
    {
      host: api_options[service],
      version: 'v2',
      debug: debug?,
      return_json: false,
      commodity_id: code,
    }
  end

  private

  attr_reader :service, :code

  def api_options
    Rails.application.config.api_options
  end

  def debug?
    Rails.logger.debug?
  end
end
