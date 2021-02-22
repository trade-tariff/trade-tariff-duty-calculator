module Wizard
  module Steps
    class ImportDestination < Base
      OPTIONS = [
        OpenStruct.new(id: 'gb', name: 'England, Scotland or Wales (GB)'),
        OpenStruct.new(id: 'ni', name: 'Northern Ireland'),
      ].freeze

      STEP_ID = '2'.freeze

      attribute 'import_destination', :string

      validates :import_destination, presence: true

      def import_destination
        super || user_session.import_destination
      end

      def save
        user_session.import_destination = import_destination
      end
    end
  end
end
