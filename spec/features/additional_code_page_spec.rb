RSpec.describe 'Additional Code Page', type: :feature do
  include_context 'GB to NI' do
    let(:applicable_additional_codes) do
      {
        '105' => {
          'measure_type_description' => 'third-country duty',
          'heading' => {
            'overlay' => 'Describe your goods in more detail',
            'hint' => 'To trade this commodity, you need to specify an additional 4 digits, known as an additional code',
          },
          'additional_codes' => [
            {
              'code' => '2600',
              'overlay' => 'The product I am importing is COVID-19 critical',
              'hint' => "Read more about the <a target='_blank' href='https://www.gov.uk/government/news/hmg-suspends-import-tariffs-on-covid-19-products-to-fight-virus'>suspension of tariffs on COVID-19 critical goods [opens in a new browser window]</a>",
            },
            {
              'code' => '2601',
              'overlay' => 'The product I am importing is not COVID-19 critical',
              'hint' => '',
            },
          ],
        },

        '552' => {
          'measure_type_description' => 'some type of duty',
          'heading' => {
            'overlay' => 'Describe your goods in more detail',
            'hint' => 'To trade this commodity, you need to specify an additional 4 digits, known as an additional code',
          },
          'additional_codes' => [
            {
              'code' => 'B999',
              'overlay' => 'Other',
              'hint' => '',
              'type' => 'preference',
              'measure_sid' => '20511102',
            },
            {
              'code' => 'B349',
              'overlay' => 'Hunan Hualian China Industry Co., Ltd; Hunan Hualian Ebillion China Industry Co., Ltd; Hunan Liling Hongguanyao China Industry Co., Ltd; Hunan Hualian Yuxiang China Industry Co., Ltd.',
              'hint' => '',
              'type' => 'preference',
              'measure_sid' => '20511103',
            },
          ],
        },
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

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::AdditionalCode.id]).to be_empty
    end

    it 'does store the answer on the session' do
      select('2600 - The product I am importing is COVID-19 critical', from: 'wizard_steps_additional_code[additional_code]')

      click_on('Continue')

      expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::AdditionalCode.id]).to eq('105' => '2600')
    end

    it 'removes the value stored under the session key when going back to the previous question' do
      select('2600 - The product I am importing is COVID-19 critical', from: 'wizard_steps_additional_code[additional_code]')

      click_on('Continue')

      visit customs_value_path

      expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::AdditionalCode.id)).to be false
    end
  end
end
