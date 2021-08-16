RSpec.describe Api::Commodity, :user_session, type: :model do
  subject(:commodity) { described_class.build(service, commodity_code) }

  let(:commodity_code) { '0702000007' }
  let(:service) { :uk }
  let(:user_session) { build(:user_session) }

  before do
    allow(Uktt::Commodity).to receive(:new).and_call_original
  end

  it_behaves_like 'a resource that has attributes',
                  id: 'flibble',
                  producline_suffix: '80',
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
    it { expect(commodity.zero_mfn_duty).to be(false) }
  end

  describe '#trade_defence' do
    it { expect(commodity.trade_defence).to be(true) }
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

    it { expect(commodity.applicable_measure_units).to eq(expected_units) }
  end

  describe '#formatted_commodity_code' do
    context 'when an additional_code is passed' do
      let(:additional_code) { 'B787' }

      it { expect(commodity.formatted_commodity_code(additional_code)).to eq('0702 00 00 07 (B787)') }
    end

    context 'when a nil additional_code is passed' do
      let(:additional_code) { nil }

      it { expect(commodity.formatted_commodity_code(additional_code)).to eq('0702 00 00 07') }
    end

    context 'when no additional_code is passed' do
      it { expect(commodity.formatted_commodity_code).to eq('0702 00 00 07') }
    end
  end

  describe '#applicable_measures' do
    let(:commodity_code) { '1516209821' }

    it 'filters out VAT measures' do
      expect(commodity.applicable_measures.select(&:vat)).to be_empty
    end

    it 'filters out additional code measures' do
      expect(commodity.applicable_measures.select(&:additional_code)).to be_empty
    end

    context 'when there are additional code answers on the session' do
      let(:user_session) { build(:user_session, additional_code: { 'uk' => { '552' => 'C114' } }) }
      let(:targeted_measure_sid) {  20_041_415 } # Definitive anti-dumping

      it 'filters in measures which match the additional_code' do
        has_measure = commodity.applicable_measures.any? { |measure| measure.id == targeted_measure_sid }

        expect(has_measure).to be(true)
      end
    end
  end

  describe '#applicable_excise_measures' do
    it { expect(commodity.applicable_excise_measures.all?(:excise)).to eq(true) }
  end

  describe '#applicable_excise_measure_units' do
    let(:commodity_code) { '0103921100' }

    context 'when there are excise units' do
      let(:service) { 'uk' }

      let(:expected_units) do
        {
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

      it { expect(commodity.applicable_excise_measure_units).to eq(expected_units) }
    end

    context 'when there are no excise units' do
      let(:service) { 'xi' } # XI doesn't have uk  excise measures

      let(:expected_units) { {} }

      it { expect(commodity.applicable_excise_measure_units).to eq(expected_units) }
    end
  end
end
