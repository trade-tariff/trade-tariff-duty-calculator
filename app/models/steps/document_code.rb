module Steps
  class DocumentCode < Steps::Base
    include CommodityHelper

    STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

    attribute :measure_type_id, :string
    attribute :document_code_uk, :string
    attribute :document_code_xi, :string

    validates :measure_type_id, presence: true

    def document_code_uk
      super || user_session.document_code_uk[measure_type_id]
    end

    def document_code_xi
      super || user_session.document_code_xi[measure_type_id]
    end

    def save
      user_session.document_code_uk = { measure_type_id => JSON.parse(document_code_uk) } if document_code_uk.present?
      user_session.document_code_xi = { measure_type_id => JSON.parse(document_code_xi) } if document_code_xi.present?
    end

    def options_for_select_for(source:)
      available_document_codes_for(source: source).map { |doc| build_option(doc[:code], doc[:description]) if doc[:code].present? }.compact
    end

    def next_step_path
      return document_codes_path(next_measure_type_id) if next_measure_type_id.present?
      return excise_path(applicable_excise_measure_type_ids.first) if applicable_excise_additional_codes? && Rails.application.config.excise_step_enabled
      return vat_path if applicable_vat_options.keys.count > 1

      confirm_path
    end

    def previous_step_path
      return additional_codes_path(last_measure_type_id_for_additional_codes) if last_measure_type_id_for_additional_codes.present?
      return measure_amount_path if filtered_commodity.applicable_measure_units.present?

      customs_value_path
    end

    private

    def available_document_codes_for(source:)
      return {} if applicable_document_codes.blank? || applicable_document_codes[source].blank? || applicable_document_codes[source][measure_type_id].blank?

      applicable_document_codes[source][measure_type_id]
    end

    def build_option(code, description)
      OpenStruct.new(
        id: code,
        name: "#{code} - #{description}",
      )
    end

    def last_measure_type_id_for_additional_codes
      applicable_measure_type_ids.last
    end

    def next_measure_type_id
      return nil if next_measure_type_index > document_codes_applicable_measure_type_ids.size - 1

      document_codes_applicable_measure_type_ids[next_measure_type_index]
    end

    def previous_measure_type_id
      return nil if previous_measure_type_index.negative?

      document_codes_applicable_measure_type_ids[previous_measure_type_index]
    end

    def next_measure_type_index
      @next_measure_type_index ||= document_codes_applicable_measure_type_ids.find_index(measure_type_id) + 1
    end

    def previous_measure_type_index
      @previous_measure_type_index ||= document_codes_applicable_measure_type_ids.find_index(measure_type_id) - 1
    end
  end
end
