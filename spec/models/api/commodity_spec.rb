RSpec.describe Api::Commodity, type: :model do
  subject(:commodity) { described_class.build(service, commodity_code) }

  let(:commodity_code) { '0702000007' }
  let(:service) { :uk }

  before do
    allow(Uktt::Commodity).to receive(:new).and_call_original
  end

  it_behaves_like 'a resource that has attributes', producline_suffix: '80',
                                                    number_indents: 1,
                                                    description: 'Cherry Tomatoes',
                                                    goods_nomenclature_item_id: '0702000007',
                                                    bti_url: 'https://www.gov.uk/guidance/check-what-youll-need-to-get-a-legally-binding-decision-on-a-commodity-code',
                                                    formatted_description: 'Cherry tomatoes',
                                                    description_plain: 'Cherry tomatoes',
                                                    consigned: false,
                                                    consigned_from: nil,
                                                    basic_duty_rate: '<span>8.00</span> %',
                                                    meursing_code: false,
                                                    declarable: true,
                                                    footnotes: [],
                                                    section: 'foo',
                                                    chapter: 'foo',
                                                    heading: 'foo',
                                                    ancestors: [],
                                                    import_measures: [],
                                                    export_measures: []

  describe '#description' do
    it 'returns the expected description' do
      expect(commodity.description).to eq('Cherry Tomatoes')
    end

    it 'returns a safe html description' do
      expect(commodity.description).to be_html_safe
    end
  end

  describe '#code' do
    it 'returns the goods_nomenclature_item_id' do
      expect(commodity.code).to eq(commodity.goods_nomenclature_item_id)
    end
  end

  describe '#import_measures' do
    it 'returns a list of measures' do
      all_are_measures = commodity.import_measures.all? { |resource| resource.is_a?(Api::Measure) }

      expect(all_are_measures).to be(true)
    end
  end

  describe '#export_measures' do
    it 'returns a list of measures' do
      all_are_measures = commodity.export_measures.all? { |resource| resource.is_a?(Api::Measure) }

      expect(all_are_measures).to be(true)
    end
  end

  describe '#zero_mfn_duty' do
    it 'returns false' do
      expect(commodity.zero_mfn_duty).to be(false)
    end
  end

  describe '#trade_defence' do
    it 'returns true' do
      expect(commodity.trade_defence).to be(true)
    end
  end

  describe '#applicable_measure_units' do
    let(:expected_units) do
      {
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
      }
    end

    it 'returns the expected units' do
      expect(commodity.applicable_measure_units).to eq(expected_units)
    end
  end

  describe '#formatted_commodity_code' do
    it 'returns the commodity commodity code' do
      expect(commodity.formatted_commodity_code).to eq('0702 00 00 07')
    end
  end

  describe '#company_defensive_measures?' do
    subject(:commodity) { described_class.new(import_measures: measures) }

    let(:measures) { [{ additional_code: additional_code }] }

    context 'when there is an additional code for a company' do
      let(:additional_code) { { code: 'A111' } }

      it { is_expected.to be_company_defensive_measures }
    end

    context 'when there is an additional code not for a company' do
      let(:additional_code) { { code: 'Z111' } }

      it { is_expected.not_to be_company_defensive_measures }
    end

    context 'when no additional code is specified' do
      let(:additional_code) { nil }

      it { is_expected.not_to be_company_defensive_measures }
    end
  end
end
