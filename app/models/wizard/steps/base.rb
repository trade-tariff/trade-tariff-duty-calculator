module Wizard
  module Steps
    class Base
      include ActiveModel::Model
      include ActiveModel::Attributes

      attr_reader :session

      def initialize(session, attributes = {})
        @session = session

        clean_session if attributes.empty?

        super(attributes)
      end

      def persisted?
        false
      end

      private

      def clean_session
        return if keys_to_remove.empty?

        session.delete(*keys_to_remove)
      end

      def keys_to_remove
        session.keys.map(&:to_i).uniq.select { |key| key > self.class::STEP_ID }
      end
    end
  end
end
