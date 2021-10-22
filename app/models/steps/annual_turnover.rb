module Steps
  class AnnualTurnover < Steps::Base
    STEPS_TO_REMOVE_FROM_SESSION = %w[
      planned_processing
      certificate_of_origin
      document_code
      excise
      vat
    ].freeze

    attribute :annual_turnover, :string

    validates :annual_turnover, presence: true

    def annual_turnover
      super || user_session.annual_turnover
    end

    def save
      user_session.annual_turnover = annual_turnover
    end

    def next_step_path
      return duty_path if user_session.annual_turnover == 'yes'

      planned_processing_path
    end

    def previous_step_path
      final_use_path
    end

    def options
      [
        OpenStruct.new(id: 'yes', name: "My company's turnover was less than £500,000"),
        OpenStruct.new(id: 'no', name: "My company's turnover was £500,000 or more"),
      ]
    end
  end
end
