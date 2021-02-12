require 'rails_helper'

RSpec.describe 'Import Destination Page', type: :feature do
  before do
    visit '/duty-calculator/123455/import-date'

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2030')

    click_on('Continue')
  end

  it 'does not store an invalid import destination on the session' do
    click_on('Continue')

    expect(Capybara.current_session.driver.request.session.key?(:import_destination)).to be false
  end

  it 'does store a invalid import date on the session' do
    choose(option: '2')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session[:import_destination]).to eq('2')
  end
end
