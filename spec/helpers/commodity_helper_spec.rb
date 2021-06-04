RSpec.describe CommodityHelper do
  before do
    allow(helper).to receive(:user_session).and_return(user_session)
  end

  let(:commodity_source) { 'xi' }
  let(:commodity_code) { '0102291010' }
  let(:import_destination) { 'XI' }
  let(:as_of) { Time.zone.today.iso8601 }

  describe '#filtered_commodity' do
    before do
      allow(Api::Commodity).to receive(:build)
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

      let(:expected_filter) do
        {
          'as_of' => Time.zone.today.iso8601,
          'filter[geographical_area_id]' => 'GB',
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
    before do
      allow(Api::Commodity).to receive(:build)
    end

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
end
