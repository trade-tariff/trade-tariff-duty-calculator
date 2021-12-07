RSpec.describe ApplicableMeasureUnitMerger, :user_session do
  subject(:service) { described_class.new }

  describe '#call' do
    before do
      allow(Api::Commodity).to receive(:build).and_call_original
    end

    context 'when on the deltas route' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_customs_value,
          :with_measure_amount,
          :deltas_applicable,
          commodity_code: '0103921100',
        )
      end

      let(:expected_units) do
        {
          'ASV' => {
            'measurement_unit_code' => 'ASV',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '% vol',
            'unit_question' => 'What is the alcohol percentage (%) of the goods you are importing?',
            'unit_hint' => 'Enter the alcohol by volume (ABV) percentage',
            'unit' => 'percent',
          },
          'DTN' => {
            'measurement_unit_code' => 'DTN',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '100 kg',
            'unit_question' => 'What is the weight of the goods you will be importing?',
            'unit_hint' => 'Enter the value in decitonnes (100kg)',
            'unit' => 'x 100 kg',
            'measure_sids' => [2_046_828],
          },
          'RET' => {
            'measurement_unit_code' => 'RET',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => 'GBP',
            'unit_question' => 'What is the retail price of the goods you will be importing?',
            'unit_hint' => 'Enter the value in pounds',
            'unit' => '£',
            'measure_sids' => [-1_010_806_389],
          },
          'MIL' => {
            'measurement_unit_code' => 'MIL',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '1,000 p/st',
            'unit_question' => 'How many items will you be importing?',
            'unit_hint' => 'Enter the value in thousands of items',
            'unit' => 'x 1,000 items',
            'measure_sids' => [-1_010_806_389],
          },
        }
      end

      it 'fetches the xi commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'xi',
          '0103921100',
          anything,
        )
      end

      it 'fetches the uk commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'uk',
          '0103921100',
          anything,
        )
      end

      it { expect(service.call).to eq(expected_units) }
    end

    context 'when on an xi route' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_customs_value,
          :with_measure_amount,
          commodity_source: 'xi',
          commodity_code: '0103921100',
        )
      end

      let(:expected_units) do
        {
          'DTN' => {
            'measurement_unit_code' => 'DTN',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '100 kg',
            'unit_question' => 'What is the weight of the goods you will be importing?',
            'unit_hint' => 'Enter the value in decitonnes (100kg)',
            'unit' => 'x 100 kg',
            'measure_sids' => [2_046_828],
          },
          'RET' => {
            'measurement_unit_code' => 'RET',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => 'GBP',
            'unit_question' => 'What is the retail price of the goods you will be importing?',
            'unit_hint' => 'Enter the value in pounds',
            'unit' => '£',
            'measure_sids' => [-1_010_806_389],
          },
          'MIL' => {
            'measurement_unit_code' => 'MIL',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '1,000 p/st',
            'unit_question' => 'How many items will you be importing?',
            'unit_hint' => 'Enter the value in thousands of items',
            'unit' => 'x 1,000 items',
            'measure_sids' => [-1_010_806_389],
          },
        }
      end

      it 'fetches the xi commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'xi',
          '0103921100',
          anything,
        )
      end

      it 'fetches the uk commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'uk',
          '0103921100',
          anything,
        )
      end

      it { expect(service.call).to eq(expected_units) }
    end

    context 'when on a uk route' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_customs_value,
          :with_measure_amount,
          commodity_source: 'uk',
          commodity_code: '0103921100',
        )
      end

      let(:expected_units) do
        {
          'ASV' => {
            'measurement_unit_code' => 'ASV',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '% vol',
            'unit_question' => 'What is the alcohol percentage (%) of the goods you are importing?',
            'unit_hint' => 'Enter the alcohol by volume (ABV) percentage',
            'unit' => 'percent',
          },
          'DTN' => {
            'measurement_unit_code' => 'DTN',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '100 kg',
            'unit_question' => 'What is the weight of the goods you will be importing?',
            'unit_hint' => 'Enter the value in decitonnes (100kg)',
            'unit' => 'x 100 kg',
            'measure_sids' => [2_046_828],
          },
          'RET' => {
            'measurement_unit_code' => 'RET',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => 'GBP',
            'unit_question' => 'What is the retail price of the goods you will be importing?',
            'unit_hint' => 'Enter the value in pounds',
            'unit' => '£',
            'measure_sids' => [-1_010_806_389],
          },
          'MIL' => {
            'measurement_unit_code' => 'MIL',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '1,000 p/st',
            'unit_question' => 'How many items will you be importing?',
            'unit_hint' => 'Enter the value in thousands of items',
            'unit' => 'x 1,000 items',
            'measure_sids' => [-1_010_806_389],
          },
        }
      end

      it 'does not fetch the xi commodity' do
        service.call

        expect(Api::Commodity).not_to have_received(:build).with(
          'xi',
          '0103921100',
          anything,
        )
      end

      it 'fetches the uk commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'uk',
          '0103921100',
          anything,
        )
      end

      it { expect(service.call).to eq(expected_units) }
    end
  end
end
