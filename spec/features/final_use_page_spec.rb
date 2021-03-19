RSpec.describe 'Final Use Page', type: :feature do
  include_context 'GB to NI' do
    before do
      choose(option: 'yes')

      click_on('Continue')
    end

    it 'does not store an empty answer on the session' do
      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::FinalUse.id)).to be false
    end

    it 'does store the answer on the session' do
      choose(option: 'yes')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::FinalUse.id]).to eq('yes')
    end

    it 'loses its session key when going back to the previous question' do
      choose(option: 'yes')

      click_on('Continue')

      click_on('Back')
      click_on('Back')

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::FinalUse.id)).to be false
    end

    context 'when importing from GB to NI, with no trade trade defence and non zero duty' do
      it 'redirects to planned_processing_path' do
        choose(option: 'yes')

        click_on('Continue')

        expect(page).to have_current_path(planned_processing_path(service_choice: service_choice, commodity_code: commodity_code))
      end
    end
  end
end
