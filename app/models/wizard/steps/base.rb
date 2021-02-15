module Wizard
  module Steps
    class Base
      include ActiveModel::Model
      include ActiveModel::Attributes

      attr_reader :session

      def initialize(session, attributes = {})
        @session = session

        super(attributes)
      end

      def persisted?
        false
      end
    end
  end
end
