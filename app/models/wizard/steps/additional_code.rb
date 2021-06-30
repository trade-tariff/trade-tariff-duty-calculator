module Wizard
  module Steps
    class AdditionalCode < Wizard::Steps::Base
      include CommodityHelper

      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      attribute :measure_type_id, :string
      attribute :additional_code, :string

      validates :measure_type_id, presence: true
      validates :additional_code, presence: true

      def additional_code
        super || user_session.additional_code[measure_type_id]
      end

      def save
        user_session.additional_code = {
          user_session.commodity_source => user_session.additional_code.merge(
            measure_type_id => additional_code,
          ),
        }
      end

      def options_for_select
        available_additional_codes.map { |ac| build_option(ac['code'], ac['overlay']) }
      end

      def measure_type_description
        applicable_additional_codes[measure_type_id]['measure_type_description'].downcase
      end

      def next_step_path
        return additional_codes_path(next_measure_type_id) if next_measure_type_id.present?
        return vat_path if applicable_vat_options.keys.count > 1

        confirm_path
      end

      def previous_step_path
        return additional_codes_path(previous_measure_type_id) if previous_measure_type_id.present?

        return measure_amount_path if filtered_commodity.applicable_measure_units.present?

        customs_value_path
      end

      private

      def available_additional_codes
        @available_additional_codes ||= applicable_additional_codes[measure_type_id]['additional_codes']
      end

      def build_option(code, overlay)
        OpenStruct.new(
          id: code,
          name: "#{code} - #{overlay}".html_safe,
        )
      end

      def next_measure_type_id
        return nil if next_measure_type_index > available_measure_types.size - 1

        available_measure_types[next_measure_type_index]
      end

      def previous_measure_type_id
        return nil if previous_measure_type_index.negative?

        available_measure_types[previous_measure_type_index]
      end

      def available_measure_types
        @available_measure_types ||= applicable_additional_codes.keys
      end

      def next_measure_type_index
        @next_measure_type_index ||= available_measure_types.find_index(measure_type_id) + 1
      end

      def previous_measure_type_index
        @previous_measure_type_index ||= available_measure_types.find_index(measure_type_id) - 1
      end
    end
  end
end
