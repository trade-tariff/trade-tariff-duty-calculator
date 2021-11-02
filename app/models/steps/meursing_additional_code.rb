module Steps
  class MeursingAdditionalCode < Steps::Base
    attribute :meursing_additional_code, :string

    validates :meursing_additional_code, format: { with: /\A\d{3}\z/ }

    def meursing_additional_code
      super || user_session.meursing_additional_code
    end

    def save
      user_session.meursing_additional_code = meursing_additional_code
    end

    def next_step_path
      customs_value_path
    end

    def previous_step_path
      return annual_turnover_path if user_session.annual_turnover == 'yes'
      return planned_processing_path if user_session.planned_processing.present? && user_session.acceptable_processing?

      interstitial_path
    end
  end
end
