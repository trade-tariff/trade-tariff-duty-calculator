FactoryBot.define do
  factory :country_of_origin, class: 'Wizard::Steps::CountryOfOrigin' do
    country_of_origin { '' }
    zero_mfn_duty { '' }
    trade_defence { '' }

    initialize_with do
      parameters = ActionController::Parameters.new(country_of_origin: country_of_origin).permit(:country_of_origin)
      opts = {}
      opts[:zero_mfn_duty] = zero_mfn_duty unless zero_mfn_duty.nil?
      opts[:trade_defence] = trade_defence unless trade_defence.nil?

      new(user_session, parameters, opts)
    end
  end
end
