require 'rails_helper'

RSpec.describe 'Import Date Page', type: :feature do
  it 'does not store an invalid import date on the session' do
    visit '/duty-calculator/123455/import-date'

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2001')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session.key?(:import_date)).to be false
  end

  it 'does store a invalid import date on the session' do
    visit '/duty-calculator/123455/import-date'

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '3000')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session[:import_date]).to eq('3000-12-12')
  end

  it 'redirects to import-destination page if the validation is successful' do
    visit '/duty-calculator/123455/import-date'

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '3000')

    click_on('Continue')

    expect(page).to have_current_path('/duty-calculator/123455/import-destination')
  end
end
