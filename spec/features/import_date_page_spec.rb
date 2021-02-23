require 'rails_helper'

RSpec.describe 'Import Date Page', type: :feature do
  let(:commodity_code) { '1234567890' }
  let(:service_choice) { 'uk' }

  it 'does not store an invalid import date on the session' do
    visit import_date_path(commodity_code: commodity_code, service_choice: service_choice)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2001')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session.key?(Wizard::Steps::ImportDate::STEP_ID)).to be false
  end

  it 'does store a invalid import date on the session' do
    visit import_date_path(commodity_code: commodity_code, service_choice: service_choice)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '3000')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session[Wizard::Steps::ImportDate::STEP_ID]).to eq('3000-12-12')
  end

  it 'redirects to import destination page if the validation is successful' do
    visit import_date_path(commodity_code: commodity_code, service_choice: service_choice)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '3000')

    click_on('Continue')

    expect(page).to have_current_path(import_destination_path(commodity_code: commodity_code, service_choice: service_choice))
  end
end
