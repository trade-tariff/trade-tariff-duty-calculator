RSpec.describe 'Country of Origin Page', type: :feature do
  let(:commodity_code) { '0702000007' }
  let(:referred_service) { 'uk' }
  let(:import_into) { 'UK' }
  let(:row_to_ni_flag) { 'false' }

  before do
    allow(Rails.configuration).to receive(:row_to_ni).and_return(row_to_ni_flag)

    visit import_date_path(commodity_code: commodity_code, referred_service: referred_service)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2030')

    click_on('Continue')

    choose(option: import_into)

    click_on('Continue')
  end

  it 'does not store an empty geographical area id on the session' do
    click_on('Continue')

    expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::CountryOfOrigin.id)).to be false
  end

  it 'loses its session key when going back to the previous question' do
    select('United Kingdom (Northern Ireland)', from: 'wizard_steps_country_of_origin[country_of_origin]')

    click_on('Continue')

    click_on('Back')
    click_on('Back')

    expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::CountryOfOrigin.id)).to be false
  end

  it 'does store the country of origin date on the session' do
    select('United Kingdom (Northern Ireland)', from: 'wizard_steps_country_of_origin[country_of_origin]')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::CountryOfOrigin.id]).to eq('XI')
  end

  context 'when importing into XI' do
    let(:import_into) { 'XI' }

    it 'does store the EU country of origin on the session' do
      choose(option: 'EU')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::CountryOfOrigin.id]).to eq('EU')
    end
  end

  context 'when ROW_TO_NI flag is turned off' do
    let(:import_into) { 'XI' }

    it 'does not show the third option' do
      expect(page).not_to have_content('Countries outside of GB and European Union')
    end
  end

  context 'when ROW_TO_NI flag is turned on' do
    let(:import_into) { 'XI' }
    let(:row_to_ni_flag) { 'true' }

    it 'does not show the third option' do
      expect(page).to have_content('Countries outside of GB and European Union')
    end
  end
end
