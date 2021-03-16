RSpec.describe 'Country of Origin Page', type: :feature do
  let(:commodity_code) { '1234567890' }
  let(:service_choice) { 'uk' }
  let(:import_into) { 'GB' }

  before do
    visit import_date_path(commodity_code: commodity_code, service_choice: service_choice)

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

  it 'does store the country of origin date on the session' do
    select('United Kingdom (Northern Ireland)', from: 'wizard_steps_country_of_origin[country_of_origin]')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::CountryOfOrigin.id]).to eq('XI')
  end

  it 'loses its session key when going back to the previous question' do
    select('United Kingdom (Northern Ireland)', from: 'wizard_steps_country_of_origin[country_of_origin]')

    click_on('Continue')

    click_on('Back')
    click_on('Back')

    expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::CountryOfOrigin.id)).to be false
  end

  context 'when importing from NI to GB' do
    it 'redirects to duty path' do
      select('United Kingdom (Northern Ireland)', from: 'wizard_steps_country_of_origin[country_of_origin]')

      click_on('Continue')

      expect(page).to have_current_path(duty_path(service_choice: service_choice, commodity_code: commodity_code))
    end
  end

  context 'when importing from GB to NI, with no trade trade defence and non zero duty' do
    let(:import_into) { 'XI' }
    let(:import_from) { 'GB' }

    let(:filter) do
      {
        'filter[geographical_area_id]' => import_from,
      }
    end

    let(:commodity) { double(Uktt::Commodity) }
    let(:filtered_commodity) { double(Uktt::Commodity) }
    let(:description) { 'Some description' }

    before do
      allow(commodity).to receive(:trade_defence).and_return(false)
      allow(commodity).to receive(:code).and_return(commodity_code)
      allow(commodity).to receive(:description).and_return(description)
      allow(filtered_commodity).to receive(:zero_mfn_duty).and_return(false)
      allow(Api::Commodity).to receive(:build).with(service_choice.to_sym, commodity_code).and_return(commodity)
      allow(Api::Commodity).to receive(:build).with(:xi, commodity_code, filter).and_return(filtered_commodity)
    end

    it 'redirects to trader_scheme_path' do
      select('United Kingdom', from: 'wizard_steps_country_of_origin[country_of_origin]')

      click_on('Continue')

      expect(page).to have_current_path(trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code))
    end
  end
end
