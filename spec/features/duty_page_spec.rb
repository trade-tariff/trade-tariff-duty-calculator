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
    let(:exchange_rate) { instance_double(Api::ExchangeRate) }
    let(:rate) { 0.0034567 }

    before do
      allow(Api::ExchangeRate).to receive(:for).with('GBP').and_return(exchange_rate)
      allow(exchange_rate).to receive(:rate).and_return(rate)

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

      click_on('Calculate import duties')
    end

    it 'displays a rounded exchange rate' do
      expect(page).to have_content('0.0035 GBP to EUR')
    end
  end
end
