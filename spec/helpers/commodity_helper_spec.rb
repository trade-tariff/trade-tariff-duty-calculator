RSpec.describe CommodityHelper do
  before do
    allow(helper).to receive(:user_session).and_return(user_session)
    allow(Api::Commodity).to receive(:build).and_call_original
    allow(Thread.current[:commodity_context_service]).to receive(:call).and_call_original
  end

  let(:commodity_source) { 'xi' }
  let(:commodity_code) { '0809400500' }
  let(:import_destination) { 'XI' }
  let(:as_of) { Time.zone.today.iso8601 }

  let(:user_session) do
    build(
      :user_session,
      import_destination: import_destination,
      country_of_origin: 'GB',
      commodity_source: commodity_source,
      commodity_code: commodity_code,
    )
  end

  let(:expected_filter) do
    {
      'as_of' => Time.zone.today.iso8601,
      'filter[geographical_area_id]' => 'GB',
    }
  end

  describe '#filtered_commodity' do
    it 'retrieves commodities via the CommodityContextService' do
      helper.filtered_commodity

      expect(Thread.current[:commodity_context_service]).to have_received(:call).with(commodity_source, commodity_code, expected_filter)
    end

    context 'when the commodity source is passed' do
      it 'uses the passed commodity source' do
        helper.filtered_commodity(source: 'uk')

        expect(Api::Commodity).to have_received(:build).with(
          'uk',
          commodity_code,
          expected_filter,
        )
      end
    end

    context 'when not on RoW to NI route' do
      let(:user_session) do
        build(
          :user_session,
          import_destination: import_destination,
          country_of_origin: 'GB',
          commodity_source: commodity_source,
          commodity_code: commodity_code,
          other_country_of_origin: '',
        )
      end

      it 'returns a correctly filtered commodity' do
        helper.filtered_commodity

        expect(Api::Commodity).to have_received(:build).with(
          commodity_source,
          commodity_code,
          expected_filter,
        )
      end
    end

    context 'when on RoW to NI route' do
      let(:user_session) do
        build(
          :user_session,
          import_destination: import_destination,
          country_of_origin: 'OTHER',
          commodity_source: commodity_source,
          commodity_code: commodity_code,
          other_country_of_origin: 'AR',
        )
      end

      let(:expected_filter) do
        {
          'as_of' => Time.zone.today.iso8601,
          'filter[geographical_area_id]' => 'AR',
        }
      end

      it 'returns a correctly filtered commodity' do
        helper.filtered_commodity

        expect(Api::Commodity).to have_received(:build).with(
          commodity_source,
          commodity_code,
          expected_filter,
        )
      end
    end
  end

  describe '#commodity' do
    let(:user_session) do
      build(
        :user_session,
        import_destination: import_destination,
        commodity_source: commodity_source,
        commodity_code: commodity_code,
      )
    end

    let(:expected_filter) do
      {
        'as_of' => Time.zone.today.iso8601,
      }
    end

    it 'retrieves commodities via the CommodityContextService' do
      helper.commodity

      expect(Thread.current[:commodity_context_service]).to have_received(:call).with(commodity_source, commodity_code, expected_filter)
    end

    it 'returns an unfiltered commodity' do
      helper.commodity

      expect(Api::Commodity).to have_received(:build).with(
        commodity_source,
        commodity_code,
        expected_filter,
      )
    end
  end

  describe '#applicable_vat_options' do
    let(:expected_options) do
      {
        'VAT' => 'Value added tax (20.0)',
        'VATR' => 'VAT reduced rate 5% (5.0)',
        'VATZ' => 'VAT zero rate (0.0)',
      }
    end

    it 'returns the applicable vat options' do
      expect(helper.applicable_vat_options).to eq(expected_options)
    end

    it 'always fetches data from the uk source' do
      helper.applicable_vat_options

      expect(Api::Commodity).to have_received(:build).with(
        'uk',
        commodity_code,
        expected_filter,
      )
    end
  end

  describe '#applicable_additional_codes' do
    let(:expected_options) do
      {
        'xi' => {
          '105' => {
            'additional_codes' => [
              {
                'code' => '2600',
                'hint' => "Read more about the <a target='_blank' href='https://www.gov.uk/government/news/hmg-suspends-import-tariffs-on-covid-19-products-to-fight-virus'>suspension of tariffs on COVID-19 critical goods [opens in a new browser window]</a>",
                'measure_sid' => 20_126_513,
                'overlay' => 'The product I am importing is COVID-19 critical',
              },
              {
                'code' => '2601',
                'hint' => '',
                'measure_sid' => 20_126_512,
                'overlay' => 'The product I am importing is not COVID-19 critical',
              },
            ],
            'heading' => {
              'hint' => 'To trade this commodity, you need to specify an additional 4 digits, known as an additional code',
              'overlay' => 'Describe your goods in more detail',
            },
            'measure_type_description' => 'Non preferential duty under authorised use',
          },
        },
      }
    end

    it 'returns the applicable additional codes' do
      expect(helper.applicable_additional_codes).to eq(expected_options)
    end
  end

  describe '#applicable_excise_additional_codes' do
    let(:expected_options) do
      {
        'xi' => {
          '306' => {
            'measure_type_description' => 'Excises',
            'heading' => nil,
            'additional_codes' => [
              {
                'code' => 'X520',
                'overlay' => '520 - Light oil: unrebated (unmarked) – other unrebated light oil',
                'hint' => '',
                'measure_sid' => -485_461,
              },
              {
                'code' => 'X522',
                'overlay' => '522 - Light oil: rebated – unleaded petrol',
                'hint' => '',
                'measure_sid' => -485_453,
              },
              {
                'code' => 'X541',
                'overlay' => '541 - Heavy oil: unrebated (unmarked, including Diesel Engine Road Vehicle (DERV) or road fuel extender and unmarked kerosene or unmarked gas oil for which no marking waiver has been granted)',
                'hint' => '',
                'measure_sid' => -485_455,
              },
              {
                'code' => 'X542',
                'overlay' => '542 - Heavy oil: kerosene to be used as motor fuel off road or in an excepted vehicle',
                'hint' => '',
                'measure_sid' => -485_456,
              },
              {
                'code' => 'X551',
                'overlay' => '551 - Heavy oil: kerosene (marked or unmarked under marking waiver, including heavy oil aviation turbine fuel) to be used other than as motor fuel off-road or in an excepted vehicle',
                'hint' => '',
                'measure_sid' => -485_457,
              },
              {
                'code' => 'X556',
                'overlay' => '556 - Heavy oil: gas oil (marked or unmarked under marking waiver)',
                'hint' => '',
                'measure_sid' => -485_458,
              },
              {
                'code' => 'X561',
                'overlay' => '561 - Heavy oil: fuel oil (unmarked)',
                'hint' => '',
                'measure_sid' => -485_459,
              },
              {
                'code' => 'X570',
                'overlay' => '570 - Heavy oil: other (unmarked)',
                'hint' => '',
                'measure_sid' => -485_460,
              },
            ],
          },
        },
      }
    end

    it 'returns the applicable additional codes' do
      expect(helper.applicable_excise_additional_codes).to eq(expected_options)
    end
  end

  describe '#applicable_measure_units' do
    let(:expected_measure_units) do
      {
        'DTN' => {
          'abbreviation' => '100 kg',
          'measure_sids' => [20_005_920, 20_056_507, 20_073_335, 20_076_779, 20_090_066, 20_105_690, 20_078_066, 20_102_998, 20_108_866, 20_085_014],
          'measurement_unit_code' => 'DTN',
          'measurement_unit_qualifier_code' => '',
          'unit' => 'x 100 kg',
          'unit_hint' => 'Enter the value in decitonnes (100kg)',
          'unit_question' => 'What is the weight of the goods you will be importing?',
        },
      }
    end

    context 'when deltas are applicable' do
      let(:user_session) { build(:user_session, :with_commodity_information, :deltas_applicable) }

      it 'fetches the uk commodity' do
        helper.applicable_measure_units

        expect(Api::Commodity).to have_received(:build).with('uk', anything, anything)
      end

      it 'fetches the xi commodity' do
        helper.applicable_measure_units

        expect(Api::Commodity).to have_received(:build).with('xi', anything, anything)
      end

      it 'fetches the measure units' do
        expect(helper.applicable_measure_units).to eq(expected_measure_units)
      end
    end

    context 'when deltas are not applicable' do
      let(:user_session) { build(:user_session, :with_commodity_information) }

      it 'fetches the uk commodity' do
        helper.applicable_measure_units

        expect(Api::Commodity).to have_received(:build).with('uk', anything, anything)
      end

      it 'does not fetch the xi commodity' do
        helper.applicable_measure_units

        expect(Api::Commodity).not_to have_received(:build).with('xi', anything, anything)
      end

      it 'fetches the measure units' do
        expect(helper.applicable_measure_units).to eq(expected_measure_units)
      end
    end
  end

  describe '#applicable_measure_unit_keys' do
    let(:user_session) { build(:user_session, :with_commodity_information) }

    it 'returns the keys of the applicable_measure_units' do
      expect(helper.applicable_measure_unit_keys).to eq(%w[dtn])
    end
  end

  describe '#applicable_measure_type_ids' do
    it { expect(helper.applicable_measure_type_ids).to eq(%w[105]) }
  end

  describe '#applicable_excise_measure_type_ids' do
    it { expect(helper.applicable_excise_measure_type_ids).to eq(%w[306]) }
  end

  describe '#applicable_additional_codes?' do
    context 'when the commodity has no additional codes' do
      let(:commodity_code) { '0102291010' }

      it { expect(helper).not_to be_applicable_additional_codes }
    end

    context 'when the commodity has additional codes' do
      let(:commodity_code) { '0809400500' }

      it { expect(helper).to be_applicable_additional_codes }
    end
  end

  describe '#applicable_excise_additional_codes?' do
    context 'when the commodity has no additional codes' do
      let(:commodity_code) { '0102291010' }

      it { expect(helper).not_to be_applicable_excise_additional_codes }
    end

    context 'when the commodity has additional codes' do
      let(:commodity_code) { '0809400500' }

      it { expect(helper).to be_applicable_excise_additional_codes }
    end
  end
end
