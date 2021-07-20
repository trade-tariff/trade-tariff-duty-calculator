module Steps
  class Excise < Steps::Base
    STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

    include CommodityHelper

    attribute :measure_type_id, :string
    attribute :additional_code, :string

    validates :measure_type_id, presence: true
    validates :additional_code, presence: true

    def additional_code
      super || user_session.excise_additional_code[measure_type_id]
    end

    def save
      user_session.excise_additional_code = { measure_type_id => additional_code }
    end

    def options_for_radio_buttons
      available_additional_codes.map do |additional_code|
        OpenStruct.new(
          id: additional_code['code'].sub('X', ''),
          name: additional_code['overlay'],
        )
      end
    end

    def measure_type_description
      applicable_excise_additional_codes[measure_type_id]['measure_type_description'].downcase
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
      return {} unless applicable_excise_additional_codes?

      applicable_excise_additional_codes[measure_type_id]['additional_codes']
    end

    def next_measure_type_id; end

    def previous_measure_type_id; end

    def next_measure_type_index
      @next_measure_type_index ||= applicable_measure_type_ids.find_index(measure_type_id) + 1
    end

    def previous_measure_type_index
      @previous_measure_type_index ||= applicable_measure_type_ids.find_index(measure_type_id) - 1
    end
  end
end
