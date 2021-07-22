FactoryBot.define do
  factory :step, class: 'Steps::Base' do
    transient do
      user_session { build(:user_session) }
    end

    initialize_with do
      attributes = possible_attributes.each_with_object({}) do |(method_name, attribute_name), acc|
        acc[attribute_name] = public_send(method_name)
      end

      parameters = ActionController::Parameters.new(attributes).permit!

      Thread.current[:user_session] ||= user_session

      new(parameters)
    end
  end
end
