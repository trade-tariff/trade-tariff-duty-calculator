require 'rails_helper'

RSpec.describe 'Country of Origin Page', type: :feature do
  let(:commodity_code) { '1234567890' }
  let(:service_choice) { 'uk' }

  before do
    visit import_date_path(commodity_code: commodity_code, service_choice: service_choice)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2030')

    click_on('Continue')

    choose(option: '2')

    click_on('Continue')
  end

  it 'does not store an empty geographical area id on the session' do
    click_on('Continue')

    expect(Capybara.current_session.driver.request.session.key?(Wizard::Steps::CountryOfOrigin::STEP_ID)).to be false
  end

  xit 'loses its session key when going back to the previous question' do
    # TODO: add steps for here when the next page is available
  end
end
