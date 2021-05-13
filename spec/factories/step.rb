FactoryBot.define do
  factory :step, class: 'Wizard::Steps::Base' do
    user_session { build(:user_session) }

    initialize_with do
      attributes = possible_attributes.each_with_object({}) do |(method_name, attribute_name), acc|
        acc[attribute_name] = public_send(method_name)
      end

      parameters = ActionController::Parameters.new(attributes).permit!

      new(user_session, parameters)
    end
  end
end
