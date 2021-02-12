module Wizard
  module Steps
    class ImportDestination < Base
      OPTIONS = [
        OpenStruct.new(id: 1, name: 'England, Scotland or Wales (GB)'),
        OpenStruct.new(id: 2, name: 'Northern Ireland'),
      ].freeze

      attribute 'import_destination', :string

      validates :import_destination, presence: true

      def save
        session[:import_destination] = import_destination
      end
    end
  end
end
