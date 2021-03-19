RSpec.describe 'Trade Remedies Page', type: :feature do
  include_context 'GB to NI' do
    let(:trade_defence) { true }

    it 'redirects to customs_value_path' do
      click_on('Continue')

      expect(page).to have_current_path(customs_value_path(service_choice: service_choice, commodity_code: commodity_code))
    end
  end
end
