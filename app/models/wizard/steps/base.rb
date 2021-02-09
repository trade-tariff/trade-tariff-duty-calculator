module Wizard
  module Steps
    class Base
      include ActiveModel::Model

      attr_reader :session,
                  :attributes

      def initialize(session, attributes = {})
        @session = session
        @attributes = attributes
      end

      def persisted?
        false
      end
    end
  end
end
