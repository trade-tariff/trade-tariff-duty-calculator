module Steps
  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes
    include Rails.application.routes.url_helpers

    STEPS_TO_REMOVE_FROM_SESSION = [].freeze

    def initialize(attributes = {})
      clean_user_session if attributes.except(:measure_type_id).empty?

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

    def user_session
      UserSession.get
    end

    private

    def clean_user_session
      user_session.remove_step_ids(self.class::STEPS_TO_REMOVE_FROM_SESSION)
    end
  end
end
