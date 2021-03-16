module Wizard
  module Steps
    class Confirmation < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze
      ORDERED_STEPS = %w[
        import_date
        import_destination
        country_of_origin
        trader_scheme
        final_use
        planned_processing
        certificate_of_origin
        customs_value
        measure_amount
      ].freeze

      attr_reader :commodity

      def initialize(user_session, commodity = nil)
        super(user_session)

        @commodity = commodity
      end

      def user_answers
        ORDERED_STEPS.each_with_object([]) do |(k, _v), acc|
          next if user_session.session['answers'][k].blank?

          acc << {
            key: k,
            label: I18n.t("confirmation_page.#{k}"),
            value: format_value_for(k),
          }
        end
      end

      def path_for(key:, commodity_code:, service_choice:)
        case key
        when 'import_date' then import_date_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'import_destination' then import_destination_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'country_of_origin' then country_of_origin_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'trader_scheme' then trader_scheme_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'final_use' then final_use_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'planned_processing' then planned_processing_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'certificate_of_origin' then certificate_of_origin_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'customs_value' then customs_value_path(commodity_code: commodity_code, service_choice: service_choice)
        when 'measure_amount' then measure_amount_path(commodity_code: commodity_code, service_choice: service_choice)
        end
      end

      def next_step_path(service_choice:, commodity_code:); end

      def previous_step_path(service_choice:, commodity_code:)
        return measure_amount_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end

      private

      def format_value_for(key)
        value = user_session.session['answers'][key]

        return Date.parse(value).strftime('%d %B %Y') if key == 'import_date'
        return "£#{value.values.map(&:to_f).reduce(:+)}" if key == 'customs_value'

        if key == 'measure_amount'
          return value.map { |k, v|
            "#{v} #{commodity.applicable_measure_units[k.upcase]['unit']}"
          }.join('<br>').html_safe
        end

        value
      end
    end
  end
end
