module Steps
  class TraderScheme < Steps::Base
    STEPS_TO_REMOVE_FROM_SESSION = %w[
      final_use
      certificate_of_origin
      planned_processing
      document_code
      excise
    ].freeze

    attribute :trader_scheme, :string

    validates :trader_scheme, presence: true

    def options
      [
        OpenStruct.new(id: 'yes', name: "Yes, I am authorised under the #{market_scheme_type}"),
        OpenStruct.new(id: 'no', name: "No, I am not authorised under the #{market_scheme_type}"),
      ].freeze
    end

    def trader_scheme
      super || user_session.trader_scheme
    end

    def save
      user_session.trader_scheme = trader_scheme
    end

    def next_step_path
      return final_use_path if user_session.trader_scheme == 'yes'
      return certificate_of_origin_path if user_session.gb_to_ni_route?

      interstitial_path
    end

    def previous_step_path
      country_of_origin_path
    end
  end
end
