module Wizard
  module Steps
    class ImportDestination < Base
      OPTIONS = [
        OpenStruct.new(id: 1, name: 'England, Scotland or Wales (GB)'),
        OpenStruct.new(id: 2, name: 'Northern Ireland'),
      ].freeze

      STEP_ID = 2

      attribute 'import_destination', :string

      validates :import_destination, presence: true

      def import_destination
        super || session[STEP_ID]
      end

      def save
        session[STEP_ID] = import_destination
      end
    end
  end
end
