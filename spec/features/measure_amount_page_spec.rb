RSpec.describe 'Measure Amount Page', type: :feature do
  include_context 'GB to NI' do
    let(:attributes) do
      ActionController::Parameters.new(
        'measure_amount' => measure_amount,
        'applicable_measure_units' => {
          'DTN' => {
            'measurement_unit_code' => 'DTN',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '100 kg',
            'unit_question' => 'What is the weight of the goods you will be importing?',
            'unit_hint' => 'Enter the value in decitonnes (100kg)',
            'unit' => 'x 100 kg',
            'measure_sids' => [
              20_005_920,
              20_056_507,
              20_073_335,
              20_076_779,
              20_090_066,
              20_105_690,
              20_078_066,
              20_102_998,
              20_108_866,
              20_085_014,
            ],
          },
        },
      ).permit!
    end

    let(:measure_amount) { { 'dtn' => 500.42 } }

    before do
      # trader scheme question
      choose(option: 'no')
      click_on('Continue')

      # certificate of origin question
      choose(option: 'no')
      click_on('Continue')

      fill_in('wizard_steps_customs_value[monetary_value]', with: '1_200')

      click_on('Continue')
    end

    it 'does not store an empty answer on the session' do
      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::MeasureAmount.id)).to be false
    end

    it 'does store the answer on the session' do
      fill_in('wizard_steps_measure_amount[dtn]', with: '1_200')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::MeasureAmount.id]).to eq({ 'dtn' => '1_200' })
    end

    it 'does not lose its session key when going back to the previous question' do
      fill_in('wizard_steps_measure_amount[dtn]', with: '1_200')

      click_on('Continue')

      visit planned_processing_path

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::MeasureAmount.id)).to be true
    end
  end
end