module Wizard
  module Steps
    class ImportDate < Base
      attr_reader :import_date

      validate :import_date_in_future

      def save!
        session[:import_date] = input_date.strftime('%d/%m/%Y')
      end

    private

      def import_date_in_future
        errors.add(:import_date, :invalid_date) if input_date < Time.zone.today
      rescue Date::Error
        errors.add(:import_date, :invalid_date)
      end

      def input_date
        Date.civil(
          attributes[:'import_date(1i)'].to_i,
          attributes[:'import_date(2i)'].to_i,
          attributes[:'import_date(3i)'].to_i,
        )
      end
    end
  end
end
