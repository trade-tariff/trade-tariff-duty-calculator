module Wizard
  module Steps
    class CustomsValue < Wizard::Steps::Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      attribute :monetary_value, :string
      attribute :shipping_cost, :string
      attribute :insurance_cost, :string

      validates :monetary_value, presence: true
      validates :monetary_value, numericality: { greater_than: 0 }
      validates :shipping_cost, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
      validates :insurance_cost, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

      def monetary_value
        super || user_session.monetary_value
      end

      def shipping_cost
        super || user_session.shipping_cost
      end

      def insurance_cost
        super || user_session.insurance_cost
      end

      def save
        user_session.customs_value = {
          'monetary_value' => monetary_value,
          'shipping_cost' => shipping_cost,
          'insurance_cost' => insurance_cost,
        }
      end

      def next_step_path(service_choice:, commodity_code:)
        measure_amount_path(service_choice: service_choice, commodity_code: commodity_code)
      end

      def previous_step_path(service_choice:, commodity_code:)
        return previous_step_for_gb_to_ni(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end

      private

      def previous_step_for_gb_to_ni(service_choice:, commodity_code:)
        return trade_remedies_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.trade_defence

        certificate_of_origin_path(service_choice: service_choice, commodity_code: commodity_code)
      end
    end
  end
end
