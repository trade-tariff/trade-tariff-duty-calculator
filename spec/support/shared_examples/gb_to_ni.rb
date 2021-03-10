RSpec.shared_context 'GB to NI' do # rubocop: disable RSpec/ContextWording
  let(:commodity) { double(Uktt::Commodity) }
  let(:filtered_commodity) { double(Uktt::Commodity) }
  let(:description) { 'Some description' }
  let(:import_into) { 'XI' }
  let(:import_from) { 'GB' }
  let(:commodity_code) { '1234567890' }
  let(:service_choice) { 'uk' }
  let(:trade_defence) { false }
  let(:zero_mfn_duty) { false }

  let(:filter) do
    {
      'filter[geographical_area_id]' => import_from,
    }
  end

  before do
    allow(commodity).to receive(:trade_defence).and_return(trade_defence)
    allow(commodity).to receive(:code).and_return(commodity_code)
    allow(commodity).to receive(:description).and_return(description)
    allow(filtered_commodity).to receive(:zero_mfn_duty).and_return(zero_mfn_duty)
    allow(Api::Commodity).to receive(:build).with(service_choice.to_sym, commodity_code).and_return(commodity)
    allow(Api::Commodity).to receive(:build).with(:xi, commodity_code, filter).and_return(filtered_commodity)

    visit import_date_path(commodity_code: commodity_code, service_choice: service_choice)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2030')

    click_on('Continue')

    choose(option: import_into)

    click_on('Continue')

    select('United Kingdom', from: 'wizard_steps_country_of_origin[country_of_origin]')

    click_on('Continue')
  end
end
