module TradeTariffDutyCalculator
  module ServiceChooser
    def self.service_choices
      @service_choices ||= JSON.parse(ENV['API_SERVICE_BACKEND_URL_OPTIONS'])
    end

    def self.service_choice=(choice)
      Thread.current[:service_choice] = choice
    end

    def self.service_choice
      Thread.current[:service_choice]
    end

    def self.service_default
      ENV.fetch('SERVICE_DEFAULT', 'uk')
    end

    def self.uk?
      (service_choice || service_default) == 'uk'
    end

    def self.xi?
      service_choice == 'xi'
    end

    def self.api_host
      host = service_choices[service_choice]

      return service_choices[service_default] if host.blank?

      host
    end
  end
end
