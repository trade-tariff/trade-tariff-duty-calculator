RSpec.describe 'Vat Page', type: :feature do
  include_context 'GB to NI' do
    let(:applicable_vat_options) do
      {
        'VATZ' => 'flibble',
        'VATR' => 'foobar',
      }
    end

    before do
      # trader scheme question
      choose(option: 'no')
      click_on('Continue')

      # certificate of origin question
      choose(option: 'no')
      click_on('Continue')

      fill_in('wizard_steps_customs_value[monetary_value]', with: '1_200')

      click_on('Continue')

      fill_in('wizard_steps_measure_amount[dtn]', with: '1_200')

      click_on('Continue')
    end

    it 'does not store a value on the session' do
      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::Vat.id)).to be false
    end

    it 'does store the answer on the session' do
      choose(option: 'VATR')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::Vat.id]).to eq('VATR')
    end

    it 'does not remove session key when going back to the previous question' do
      choose(option: 'VATR')

      click_on('Continue')

      visit measure_amount_path

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::Vat.id)).to be true
    end
  end
end
