module Steps
  class Stopping < Steps::Base
    def previous_step_path
      return document_codes_path(user_session.document_code_measure_type_ids.last) if user_session.document_code?

      import_date_path(
        referred_service: user_session.referred_service,
        commodity_code: user_session.commodity_code,
      )
    end
  end
end
