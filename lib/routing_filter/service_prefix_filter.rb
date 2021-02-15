require 'routing_filter'
require 'trade_tariff_duty_calculator/service_chooser'

module RoutingFilter
  class ServicePrefixFilter < Filter
    SERVICE_CHOICE_PREFIXES =
      ::TradeTariffDutyCalculator::ServiceChooser.service_choices
                                           .keys
                                           .map { |prefix| Regexp.escape(prefix) }
                                           .join('|')
                                           .freeze

    SERVICE_CHOICE_PREFIXES_REGEX = %r{^/(#{SERVICE_CHOICE_PREFIXES})(?=/|$)}.freeze

    # Recognising paths
    def around_recognize(path, _env)
      service_choice = extract_segment!(SERVICE_CHOICE_PREFIXES_REGEX, path)

      ::TradeTariffDutyCalculator::ServiceChooser.service_choice = service_choice

      yield
    end

    def around_generate(_params)
      yield.tap do |path, _params|
        service_choice = ::TradeTariffDutyCalculator::ServiceChooser.service_choice

        prepend_segment!(path, service_choice) if service_choice.present? && service_choice != service_choice_default
      end
    end

    private

    attr_reader :path, :service_choice

    def service_choice_default
      ::TradeTariffDutyCalculator::ServiceChooser.service_default
    end
  end
end
