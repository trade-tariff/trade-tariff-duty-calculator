class ClientBuilder
  DEFAULT_VERSION = 'v2'.freeze
  DEFAULT_FORMAT = 'jsonapi'.freeze

  def initialize(service)
    @service = service
  end

  def call
    Uktt::Http.build(
      host,
      DEFAULT_VERSION,
      DEFAULT_FORMAT,
      public_routing,
    )
  end

  private

  def host
    Rails.application.config.api_options[@service]
  end

  def public_routing
    Rails.application.config.public_routing
  end
end
