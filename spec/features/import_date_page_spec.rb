RSpec.describe 'Import Date Page', type: :feature do
  let(:commodity_code) { '1234567890' }
  let(:referred_service) { 'uk' }

  it 'does not store an invalid import date on the session' do
    visit import_date_path(commodity_code: commodity_code, referred_service: referred_service)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2001')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::ImportDate.id)).to be false
  end

  it 'does store a invalid import date on the session' do
    visit import_date_path(commodity_code: commodity_code, referred_service: referred_service)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '3000')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::ImportDate.id]).to eq('3000-12-12')
  end
end
