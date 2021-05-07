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
          measure_type_id => additional_code,
        }
      end

      def options_for_select
        available_additional_codes.map { |ac| build_option(ac['code'], ac['overlay']) }
      end

      def next_step_path; end

      def previous_step_path; end

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
    end
  end
end
