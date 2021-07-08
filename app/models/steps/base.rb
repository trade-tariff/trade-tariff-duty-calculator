module Steps
  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes
    include Rails.application.routes.url_helpers

    attr_reader :user_session

    def initialize(user_session, attributes = {})
      @user_session = user_session

      clean_user_session if attributes.empty?

      super(attributes)
    end

    def self.id
      name.split('::').last.underscore
    end

    protected

    def next_step_path
      raise NotImplementedError
    end

    def previous_step_path
      raise NotImplementedError
    end

    private

    def clean_user_session
      @user_session.remove_step_ids(self.class::STEPS_TO_REMOVE_FROM_SESSION)
    end
  end
end
