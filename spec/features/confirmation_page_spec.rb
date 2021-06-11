RSpec.describe 'Confirmation Page', type: :feature do
  include_context 'GB to NI' do
    let(:measure_amount) { { 'dtn' => 500.42 } }

    let(:expected_content) do
      "Check your answers\nCommodity code 7202 11 80 00 Change\nDate of import #{I18n.l(Time.zone.today)} Change\nDestination Northern Ireland Change\nComing from United Kingdom Change\nTrader scheme No Change\nCertificate of origin No Change\nCustoms value £1,200.00 Change\nImport quantity 1_200 x 100 kg Change\nApplicable VAT rate foobar Change\nCalculate import duties\n"
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
        '/duty-calculator/vat',
      ]
    end

    let(:applicable_vat_options) do
      {
        'VATR' => 'flibble',
        'VATZ' => 'foobar',
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

      choose(option: 'VATZ')

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
