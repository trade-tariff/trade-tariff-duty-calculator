RSpec.describe 'Trade Remedies Page', type: :feature do
  let(:trade_defence) { true }

  before do
    allow(filtered_commodity).to receive(:trade_defence).and_return(trade_defence)
    allow(commodity).to receive(:trade_defence).and_return(trade_defence)
  end

  include_context 'GB to NI' do
    it 'redirects to customs_value_path' do
      click_on('Continue')

      expect(page).to have_current_path(customs_value_path)
    end
  end
end
