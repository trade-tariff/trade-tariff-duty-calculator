module Wizard
  module Steps
    class CountryOfOrigin < Base
      STEP_ID = '3'.freeze

      attribute 'geographical_area_id', :string

      validates :geographical_area_id, presence: true

      def geographical_area_id
        super || user_session.geographical_area_id
      end

      def save
        user_session.geographical_area_id = geographical_area_id
      end

      def self.options_for(service)
        Country.list(service.to_sym)
      end
    end
  end
end
