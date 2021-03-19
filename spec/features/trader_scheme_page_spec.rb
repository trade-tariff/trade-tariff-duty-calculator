require 'rails_helper'

RSpec.describe 'Trader Scheme Page', type: :feature do
  include_context 'GB to NI' do
    it 'does not store an empty answer on the session' do
      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::TraderScheme.id)).to be false
    end

    it 'does store the answer on the session' do
      choose(option: 'yes')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::TraderScheme.id]).to eq('yes')
    end

    it 'loses its session key when going back to the previous question' do
      choose(option: 'yes')

      click_on('Continue')

      visit country_of_origin_path

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::TraderScheme.id)).to be false
    end
  end
end
