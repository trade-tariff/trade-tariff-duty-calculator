module Wizard
  module Steps
    class CountryOfOrigin < Base
      STEP_ID = '3'.freeze

      attribute 'geographical_area_id', :string

      validates :geographical_area_id, presence: true

      def geographical_area_id
        super || session[STEP_ID]
      end

      def save
        session[STEP_ID] = geographical_area_id
      end

      def self.options_for(service)
        Country.list(service.to_sym)
      end
    end
  end
end
