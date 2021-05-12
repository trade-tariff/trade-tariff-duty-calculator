FactoryBot.define do
  factory :import_date, class: 'Wizard::Steps::ImportDate', parent: :step do
    transient do
      possible_attributes do
        {
          date_3i: 'import_date(3i)',
          date_2i: 'import_date(2i)',
          date_1i: 'import_date(1i)',
        }
      end

      date_3i { '' }
      date_2i { '' }
      date_1i { '' }
    end
  end
end
