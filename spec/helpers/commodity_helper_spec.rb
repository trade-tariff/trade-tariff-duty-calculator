RSpec.describe CommodityHelper do
  before do
    allow(helper).to receive(:user_session).and_return(user_session)
    allow(Api::Commodity).to receive(:build).and_call_original
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
      }
    end

    it 'returns the applicable additional codes' do
      expect(helper.applicable_additional_codes).to eq(expected_options)
    end
  end
end
