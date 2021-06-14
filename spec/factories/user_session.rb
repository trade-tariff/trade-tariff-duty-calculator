Dir[File.join(__dir__, '../../app/models/wizard/steps/', '*.rb')].sort.each { |file| require_relative file }

POSSIBLE_ANSWERS = Wizard::Steps.constants.map { |step| "Wizard::Steps::#{step}".constantize.id }

FactoryBot.define do
  factory :user_session do
    commodity_code   { nil }
    commodity_source { nil }
    referred_service { nil }
    trade_defence    { nil }
    zero_mfn_duty    { nil }
    other_country_of_origin { '' }

    initialize_with do
      answers = POSSIBLE_ANSWERS.each_with_object({}) do |answer_method, acc|
        acc[answer_method] = public_send(answer_method) if respond_to?(answer_method)
      end

      session = { 'answers' => answers.merge('other_country_of_origin' => other_country_of_origin) }
      session.merge!(attributes.stringify_keys)

      UserSession.new(session)
    end
  end

  trait :with_commodity_information do
    commodity_code { '0702000007' }
    commodity_source { 'uk' }
    referred_service { 'uk' }
  end

  trait :with_country_of_origin do
    country_of_origin { 'OTHER' }
    other_country_of_origin { 'AR' }
  end
end
