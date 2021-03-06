require 'rails_helper'

RSpec.describe 'Import Destination Page', type: :feature do
  let(:commodity_code) { '1234567890' }
  let(:service_choice) { 'uk' }

  before do
    visit import_date_path(commodity_code: commodity_code, service_choice: service_choice)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2030')

    click_on('Continue')
  end

  it 'does not store an invalid import destination on the session' do
    click_on('Continue')

    expect(Capybara.current_session.driver.request.session.key?(Wizard::Steps::ImportDestination.id)).to be false
  end

  it 'does store a invalid import date on the session' do
    choose(option: 'XI')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session[Wizard::Steps::ImportDestination.id]).to eq('XI')
  end

  it 'loses its session key when going back to the previous question' do
    choose(option: 'XI')

    click_on('Continue')

    click_on('Back')
    click_on('Back')

    expect(Capybara.current_session.driver.request.session.key?(Wizard::Steps::ImportDestination.id)).to be false
  end
end
