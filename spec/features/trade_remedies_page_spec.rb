RSpec.describe 'Trade Remedies Page', type: :feature do
  let(:trade_defence) { true }

  context 'when on GB to NI route' do
    let(:commodity) do
      instance_double(Api::Commodity)
    end

    let(:description) { 'Some description' }
    let(:import_into) { 'XI' }
    let(:import_from) { 'GB' }
    let(:commodity_code) { '7202118000' }
    let(:referred_service) { 'uk' }

    let(:default_query) do
      {
        'as_of' => Time.zone.today.iso8601,
      }
    end

    let(:filtered_query) do
      {
        'filter[geographical_area_id]' => import_from,
      }.merge(default_query)
    end

    before do
      allow(Api::Commodity).to receive(:build).with('uk', commodity_code, default_query).and_return(commodity)
      allow(commodity).to receive(:code).and_return(commodity_code)
      allow(commodity).to receive(:description).and_return(description)
      allow(commodity).to receive(:formatted_commodity_code).and_return('7202 1180 00')
      allow(commodity).to receive(:trade_defence).and_return(trade_defence)
      allow(commodity).to receive(:zero_mfn_duty).and_return(false)
      allow(Api::Commodity).to receive(:build).with('xi', commodity_code, default_query).and_return(commodity)
      allow(Api::Commodity).to receive(:build).with('xi', commodity_code, filtered_query).and_return(commodity)

      visit import_date_url(referred_service: referred_service, commodity_code: commodity_code)

      fill_in('wizard_steps_import_date[import_date(3i)]', with: Time.zone.today.day)
      fill_in('wizard_steps_import_date[import_date(2i)]', with: Time.zone.today.month)
      fill_in('wizard_steps_import_date[import_date(1i)]', with: Time.zone.today.year)

      click_on('Continue')

      choose(option: import_into)

      click_on('Continue')

      choose(option: 'GB')

      click_on('Continue')
    end

    it 'redirects to trade_remedies_path' do
      expect(page).to have_current_path(trade_remedies_path)
    end
  end
end
