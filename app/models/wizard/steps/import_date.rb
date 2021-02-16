module Wizard
  module Steps
    class ImportDate < Base
      include ActiveRecord::AttributeAssignment

      attribute :import_date, :date

      attribute 'import_date(3i)', :string
      attribute 'import_date(2i)', :string
      attribute 'import_date(1i)', :string

      validate :import_date_in_future

      STEP_ID = 1

      def initialize(session, attributes = {})
        check_attributes_validity(attributes)

        super
      end

      def import_date
        super || date_from_session
      end

      def save
        session[STEP_ID] = input_date.strftime('%Y-%m-%d')
      end

    private

      def import_date_in_future
        return if input_date.present? && input_date >= Time.zone.today

        errors.add(:import_date, :invalid_date)
      end

      def date_from_session
        return unless session.key?(STEP_ID)

        Date.parse(session[STEP_ID])
      end

      def valid_date?(attributes)
        Date.civil(
          attributes['import_date(1i)'].to_i,
          attributes['import_date(2i)'].to_i,
          attributes['import_date(3i)'].to_i,
        )
      rescue ArgumentError
        false
      end

      def input_date
        attributes['import_date']
      end

      def check_attributes_validity(attributes = {})
        return if attributes.empty? || valid_date?(attributes)

        errors.add(:import_date, :invalid_date)

        attributes.delete 'import_date(1i)'
        attributes.delete 'import_date(2i)'
        attributes.delete 'import_date(3i)'
      end
    end
  end
end
