RSpec.describe MeasureUnitMerger, :user_session do
  subject(:service) { described_class.new }

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_customs_value,
      :with_measure_amount,
      commodity_code: '0103921100',
    )
  end

  describe '#call' do
    before do
      allow(Api::Commodity).to receive(:build).and_call_original
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
          'measure_sids' => [2_046_828, 2_046_828],
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
end
