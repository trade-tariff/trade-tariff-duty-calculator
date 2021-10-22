module Steps
  class PlannedProcessing < Steps::Base
    STEPS_TO_REMOVE_FROM_SESSION = %w[
      certificate_of_origin
      document_code
      excise
    ].freeze

    attribute :planned_processing, :string

    validates :planned_processing, presence: true

    def planned_processing
      super || user_session.planned_processing
    end

    def save
      user_session.planned_processing = planned_processing
    end

    def next_step_path
      return next_step_for_gb_to_ni if user_session.gb_to_ni_route?

      next_step_for_row_to_ni
    end

    def previous_step_path
      annual_turnover_path
    end

    private

    def next_step_for_gb_to_ni
      return duty_path unless user_session.planned_processing == 'commercial_purposes'

      certificate_of_origin_path
    end

    def next_step_for_row_to_ni
      return interstitial_path if user_session.planned_processing == 'commercial_purposes'

      customs_value_path
    end
  end
end
