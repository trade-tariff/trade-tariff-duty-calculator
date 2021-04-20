RSpec.shared_context 'GB to NI' do # rubocop: disable RSpec/ContextWording
  let(:commodity) do
    Api::Commodity.build(
      commodity_source,
      commodity_code,
      default_query,
    )
  end

  let(:filtered_commodity) do
    Api::Commodity.build(
      commodity_source,
      commodity_code,
      filtered_query,
    )
  end

  let(:description) { 'Some description' }
  let(:import_into) { 'XI' }
  let(:import_from) { 'GB' }
  let(:commodity_code) { '7202118000' }
  let(:referred_service) { 'uk' }
  let(:commodity_source) { :xi }

  let(:default_query) do
    {
      'as_of' => '2030-12-12',
    }
  end

  let(:as_of_now_query) do
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

  let(:now) { Time.zone.today }

  before do
    allow(filtered_commodity).to receive(:applicable_measure_units).and_return(attributes['applicable_measure_units'])
    allow(Api::Commodity).to receive(:build).with('uk', commodity_code, default_query).and_return(commodity)
    allow(Api::Commodity).to receive(:build).with('uk', commodity_code, as_of_now_query).and_return(commodity)
    allow(Api::Commodity).to receive(:build).with('uk', commodity_code, filtered_query).and_return(commodity)
    allow(Api::Commodity).to receive(:build).with('xi', commodity_code, default_query).and_return(commodity)
    allow(Api::Commodity).to receive(:build).with('xi', commodity_code, filtered_query).and_return(filtered_commodity)

    visit import_date_path(commodity_code: commodity_code, referred_service: referred_service)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2030')

    click_on('Continue')

    choose(option: import_into)

    click_on('Continue')

    choose(option: 'GB')

    click_on('Continue')
  end
end
