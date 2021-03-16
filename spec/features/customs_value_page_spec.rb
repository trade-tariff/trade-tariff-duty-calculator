RSpec.describe 'Customs Value Page', type: :feature do
  include_context 'GB to NI' do
    before do
      allow(commodity).to receive(:applicable_measure_units).and_return({})

      choose(option: 'no')
      click_on('Continue')

      choose(option: 'no')
      click_on('Continue')
    end

    let(:expected_value) do
      {
        'insurance_cost' => '',
        'monetary_value' => '1_200',
        'shipping_cost' => '',
      }
    end

    it 'does not store an empty answer on the session' do
      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::CustomsValue.id)).to be false
    end

    it 'does store the answer on the session' do
      fill_in('wizard_steps_customs_value[monetary_value]', with: '1_200')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::CustomsValue.id]).to eq(expected_value)
    end

    it 'does not lose its session key when going back to the previous question' do
      fill_in('wizard_steps_customs_value[monetary_value]', with: '1_200')

      click_on('Continue')

      visit planned_processing_path(commodity_code: commodity_code, service_choice: service_choice)

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::CustomsValue.id)).to be true
    end

    it 'redirects to measure_amount_path' do
      fill_in('wizard_steps_customs_value[monetary_value]', with: '1_200')

      click_on('Continue')

      expect(page).to have_current_path(measure_amount_path(service_choice: service_choice, commodity_code: commodity_code))
    end
  end
end
