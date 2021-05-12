FactoryBot.define do
  factory :import_date, class: 'Wizard::Steps::ImportDate' do
    date_3i { '' }
    date_2i { '' }
    date_1i { '' }

    user_session { build(:user_session) }

    initialize_with do
      attributes = ActionController::Parameters.new(
        'import_date(3i)' => date_3i,
        'import_date(2i)' => date_2i,
        'import_date(1i)' => date_1i,
      ).permit(
        'import_date(3i)',
        'import_date(2i)',
        'import_date(1i)',
      )

      Wizard::Steps::ImportDate.new(user_session, attributes)
    end
  end
end
