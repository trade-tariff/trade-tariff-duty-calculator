module Wizard
  module Steps
    class ImportDate < Base
      attribute 'import_date(3i)', :string
      attribute 'import_date(2i)', :string
      attribute 'import_date(1i)', :string

      validate :import_date_in_future

      def import_date
        session[:import_date]
      end

      def import_date=(value)
        session[:import_date] = value
      end

      def save
        self.import_date = input_date.strftime('%Y-%m-%d')
      end

    private

      def import_date_in_future
        errors.add(:import_date, :invalid_date) if input_date < Time.zone.today
      rescue Date::Error
        errors.add(:import_date, :invalid_date)
      end

      def input_date
        Date.civil(
          attributes['import_date(1i)'].to_i,
          attributes['import_date(2i)'].to_i,
          attributes['import_date(3i)'].to_i,
        )
      end
    end
  end
end
