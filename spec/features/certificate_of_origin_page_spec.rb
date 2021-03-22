RSpec.describe 'Certificate of Origin Page', type: :feature do
  include_context 'GB to NI' do
    before do
      choose(option: 'yes')
      click_on('Continue')

      choose(option: 'yes')
      click_on('Continue')

      choose(option: 'commercial_purposes')
      click_on('Continue')
    end

    it 'does not store an empty answer on the session' do
      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::CertificateOfOrigin.id)).to be false
    end

    it 'does store the answer on the session' do
      choose(option: 'no')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::CertificateOfOrigin.id]).to eq('no')
    end

    it 'loses its session key when going back to the previous question' do
      choose(option: 'no')

      click_on('Continue')

      visit planned_processing_path

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::CertificateOfOrigin.id)).to be false
    end
  end
end
