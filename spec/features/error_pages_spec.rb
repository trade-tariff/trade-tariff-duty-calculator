RSpec.describe 'Error Pages', type: :feature do
  let(:commodity_code) { '0702000007' }
  let(:referred_service) { 'uk' }

  before do
    visit import_date_path(referred_service: referred_service, commodity_code: commodity_code)
  end

  describe '/404' do
    it 'allows users to return back to import_date page' do
      visit '/404'
      click_on('start again')

      expect(page).to have_current_path(
        import_date_path(referred_service: referred_service, commodity_code: commodity_code),
      )
    end
  end

  describe '/500' do
    it 'allows users to return back to import_date page' do
      visit '/500'
      click_on('start again')

      expect(page).to have_current_path(
        import_date_path(referred_service: referred_service, commodity_code: commodity_code),
      )
    end
  end

  describe '/422' do
    it 'allows users to return back to import_date page' do
      visit '/422'
      click_on('start again')

      expect(page).to have_current_path(
        import_date_path(referred_service: referred_service, commodity_code: commodity_code),
      )
    end
  end
end
