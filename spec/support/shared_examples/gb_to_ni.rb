RSpec.shared_context 'GB to NI' do # rubocop: disable RSpec/ContextWording
  let(:commodity) do
    instance_double(Api::Commodity)
  end

  let(:description) { 'Some description' }
  let(:import_into) { 'XI' }
  let(:import_from) { 'GB' }
  let(:commodity_code) { '7202118000' }
  let(:referred_service) { 'uk' }
  let(:trade_defence) { false }

  let(:default_query) do
    {
      'as_of' => Time.zone.today.iso8601,
    }
  end

  let(:filtered_query) do
    {
      'filter[geographical_area_id]' => import_from,
    }.merge(default_query)
  end

  let(:attributes) do
    {
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
    }
  end

  before do
    allow(commodity).to receive(:applicable_measure_units).and_return(attributes['applicable_measure_units'])
    allow(Api::Commodity).to receive(:build).with('uk', commodity_code, default_query).and_return(commodity)
    allow(Api::Commodity).to receive(:build).with('xi', commodity_code, default_query).and_return(commodity)
    allow(commodity).to receive(:code).and_return(commodity_code)
    allow(commodity).to receive(:description).and_return(description)
    allow(commodity).to receive(:formatted_commodity_code).and_return('7202 11 80 00')
    allow(commodity).to receive(:trade_defence).and_return(trade_defence)
    allow(commodity).to receive(:zero_mfn_duty).and_return(false)
    allow(commodity).to receive(:import_measures).and_return([])
    allow(commodity).to receive(:applicable_additional_codes).and_return({})
    allow(commodity).to receive(:applicable_vat_options).and_return({})
    allow(Api::Commodity).to receive(:build).with('xi', commodity_code, default_query).and_return(commodity)
    allow(Api::Commodity).to receive(:build).with('xi', commodity_code, filtered_query).and_return(commodity)

    visit import_date_url(referred_service: referred_service, commodity_code: commodity_code)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: Time.zone.today.day)
    fill_in('wizard_steps_import_date[import_date(2i)]', with: Time.zone.today.month)
    fill_in('wizard_steps_import_date[import_date(1i)]', with: Time.zone.today.year)

    click_on('Continue')

    choose(option: import_into)

    click_on('Continue')

    choose(option: 'GB')

    click_on('Continue')
  end
end
