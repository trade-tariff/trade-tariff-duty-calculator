module Steps
  class FinalUse < Steps::Base
    STEPS_TO_REMOVE_FROM_SESSION = %w[
      certificate_of_origin
      planned_processing
    ].freeze

    attribute :final_use, :string

    validates :final_use, presence: true

    def final_use
      super || user_session.final_use
    end

    def save
      user_session.final_use = final_use
    end

    def next_step_path
      return planned_processing_path if user_session.final_use == 'yes'
      return certificate_of_origin_path if user_session.gb_to_ni_route?

      trade_remedies_path
    end

    def previous_step_path
      trader_scheme_path
    end

    def options
      [
        OpenStruct.new(id: 'yes', name: I18n.t("final_use.#{locale_key}.yes_option")),
        OpenStruct.new(id: 'no', name: I18n.t("final_use.#{locale_key}.no_option")),
      ]
    end

    def heading
      I18n.t("final_use.#{locale_key}.heading")
    end

    private

    def locale_key
      return 'gb_to_ni' if user_session.gb_to_ni_route?

      'row_to_ni'
    end
  end
end
