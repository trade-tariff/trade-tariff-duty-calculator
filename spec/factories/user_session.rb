Dir[File.join(__dir__, '../../app/models/wizard/steps/', '*.rb')].sort.each { |file| require_relative file }

FactoryBot.define do
  factory :user_session do
    POSSIBLE_ANSWERS = Wizard::Steps.constants.map { |step| "Wizard::Steps::#{step}".constantize.id }

    commodity_code   { nil }
    commodity_source { nil }
    referred_service { nil }
    trade_defence    { nil }
    zero_mfn_duty    { nil }

    transient do # Set default answer values
      certificate_of_origin { nil }
      confirmation          { nil }
      country_of_origin     { nil }
      customs_value         { nil }
      final_use             { nil }
      import_date           { nil }
      import_destination    { nil }
      measure_amount        { nil }
      planned_processing    { nil }
      trader_scheme         { nil }
    end

    initialize_with do
      answers = POSSIBLE_ANSWERS.each_with_object({}) do |answer_method, acc|
        acc[answer_method] = public_send(answer_method) if respond_to?(answer_method) && public_send(answer_method)
      end

      session = { 'answers' => answers }
      session.merge!(attributes.stringify_keys)

      UserSession.new(session)
    end
  end
end
