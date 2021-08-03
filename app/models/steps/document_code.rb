module Steps
  class DocumentCode < Steps::Base
    include CommodityHelper

    STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

    attribute :measure_type_id, :string
    attribute :document_code_uk, :string
    attribute :document_code_xi, :string

    validates :document_code_uk, presence: true, if: -> { validation_applicable_for?('uk') }
    validates :document_code_xi, presence: true, if: -> { validation_applicable_for?('xi') }
    validates :measure_type_id, presence: true

    def document_code_uk
      super || user_session.document_code_uk[measure_type_id]
    end

    def document_code_xi
      super || user_session.document_code_xi[measure_type_id]
    end

    def save
      user_session.document_code_uk = { measure_type_id => document_code_uk } unless document_code_uk.nil?
      user_session.document_code_xi = { measure_type_id => document_code_xi } unless document_code_xi.nil?

      user_session.document_code_xi = user_session.document_code_xi.merge(measure_type_id => document_code_uk) if !document_code_uk.nil? && user_session.deltas_applicable?
    end

    def options_for_radio_buttons(source:)
      available_document_codes_for(source: source).uniq.map do |doc|
        build_option(doc[:code], doc[:description])
      end
    end

    def xi_options_for_radio_buttons_without_uk
      options_for_radio_buttons(source: 'xi') - options_for_radio_buttons(source: 'uk')
    end

    def next_step_path
      return document_codes_path(next_measure_type_id) if next_measure_type_id.present?
      return excise_path(applicable_excise_measure_type_ids.first) if applicable_excise_additional_codes? && Rails.application.config.excise_step_enabled
      return vat_path if applicable_vat_options.keys.count > 1

      confirm_path
    end

    def previous_step_path
      return document_codes_path(previous_measure_type_id) if previous_measure_type_id.present?
      return additional_codes_path(last_measure_type_id_for_additional_codes) if last_measure_type_id_for_additional_codes.present?
      return measure_amount_path if filtered_commodity.applicable_measure_units.present?

      customs_value_path
    end

    def valid?
      super.tap do
        errors.messages.delete(:document_code_xi) if errors.messages[:document_code_uk].present? && errors.messages[:document_code_xi].present? && user_session.deltas_applicable?
      end
    end

    private

    def available_document_codes_for(source:)
      return {} if applicable_document_codes.blank? || applicable_document_codes[source].blank? || applicable_document_codes[source][measure_type_id].blank?

      applicable_document_codes[source][measure_type_id]
    end

    def build_option(code, description)
      OpenStruct.new(
        id: code.empty? ? 'None' : code,
        name: code.present? ? "#{code} - #{description}" : 'None of the above',
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

    def validation_applicable_for?(source)
      return applicable_document_codes[source][measure_type_id].present? if user_session.deltas_applicable?

      user_session.commodity_source == source
    end
  end
end
