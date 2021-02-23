module Wizard
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

      def persisted?
        false
      end

      protected

      def next_step_path(*)
        raise('Must implement this method')
      end

      def previous_step_path(*)
        raise('Must implement this method')
      end

      private

      def clean_user_session
        @user_session.remove_keys_after(self.class::STEP_ID.to_i)
      end
    end
  end
end
