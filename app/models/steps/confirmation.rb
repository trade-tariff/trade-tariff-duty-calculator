module Steps
  class Confirmation < Steps::Base
    include CommodityHelper

    STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

    def next_step_path
      duty_path
    end

    def previous_step_path
      return vat_path if filtered_commodity(source: 'uk').applicable_vat_options.keys.size > 1
      return excise_path(user_session.excise_measure_type_ids.last) if user_session.excise_additional_code.present? && Rails.application.config.excise_step_enabled
      return document_codes_path(user_session.document_code_measure_type_ids.last) if (user_session.document_code_uk.present? || user_session.document_code_xi.present?)
      return additional_codes_path(user_session.additional_code_measure_type_ids.last) if user_session.additional_code_uk.present? || user_session.additional_code_xi.present?
      return measure_amount_path unless user_session.measure_amount.empty?

      customs_value_path
    end
  end
end
