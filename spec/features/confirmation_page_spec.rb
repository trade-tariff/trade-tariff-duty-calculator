RSpec.describe 'Confirmation Page', type: :feature do
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

    let(:expected_content) do
      "Check your answers\nCommodity code 7202 11 80 00 Change\nDate of import #{Time.zone.now.strftime('%d %b %Y')} Change\nDestination Northern Ireland Change\nComing from United Kingdom Change\nTrader scheme No Change\nCertificate of origin No Change\nCustoms value £1,200.00 Change\nImport quantity 1_200 x 100 kg Change\nCalculate import duties\n"
    end

    let(:expected_links) do
      [
        'https://dev.trade-tariff.service.gov.uk/sections',
        '/duty-calculator/uk/7202118000/import-date',
        '/duty-calculator/import-destination',
        '/duty-calculator/country-of-origin',
        '/duty-calculator/trader-scheme',
        '/duty-calculator/certificate-of-origin',
        '/duty-calculator/customs-value',
        '/duty-calculator/measure-amount',
      ]
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

    it 'contains the summary of all the previously given answers' do
      expect(page).to have_content(expected_content)
    end

    it 'contains the links that allow users to go back and change their answers' do
      expected_links.each do |link|
        expect(page).to have_link('Change', href: link)
      end
    end
  end
end
