require 'rails_helper'

RSpec.describe 'Planned Processing Page', type: :feature do
  include_context 'GB to NI' do
    before do
      # trader scheme question
      choose(option: 'yes')
      click_on('Continue')

      # final use question
      choose(option: 'yes')
      click_on('Continue')
    end

    it 'does not store an empty answer on the session' do
      click_on('Continue')

      expect(Capybara.current_session.driver.request.session.key?(Wizard::Steps::PlannedProcessing.id)).to be false
    end

    it 'does store the answer on the session' do
      choose(option: 'commercial_purposes')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session[Wizard::Steps::PlannedProcessing.id]).to eq('commercial_purposes')
    end

    it 'loses its session key when going back to the previous question' do
      choose(option: 'commercial_purposes')

      click_on('Continue')

      visit final_use_path(commodity_code: commodity_code, service_choice: service_choice)

      expect(Capybara.current_session.driver.request.session.key?(Wizard::Steps::PlannedProcessing.id)).to be false
    end

    context 'when no trade trade defence and non zero duty' do
      it 'redirects to planned_processing_path' do
        choose(option: 'commercial_purposes')

        click_on('Continue')

        expect(page).to have_current_path(certificate_of_origin_path(service_choice: service_choice, commodity_code: commodity_code))
      end
    end
  end
end
