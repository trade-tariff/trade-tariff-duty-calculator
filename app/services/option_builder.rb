class OptionBuilder
  def initialize(service)
    @service = service
  end

  def call
    {
      host: api_options[@service],
      version: 'v2',
      debug: debug?,
      format: 'jsonapi',
    }
  end

  private

  attr_reader :service, :options

  def api_options
    Rails.application.config.api_options
  end

  def debug?
    Rails.logger.debug?
  end
end
