RSpec.describe DutyOptionResult do
  subject(:result) { described_class.new }

  it_behaves_like 'a resource that has attributes',
                  type: 'tariff_preference',
                  category: :tariff_preference,
                  values: [],
                  value: 0.0,
                  footnote: '',
                  measure_sid: 3_822_192,
                  source: 'uk',
                  priority: 2,
                  warning_text: nil,
                  order_number: nil,
                  geographical_area_description: 'United Kingdom (excluding Northern Ireland)'

  describe '#footnote_suffix' do
    it { expect(result.footnote_suffix).to eq('') }

    context 'when there is a suffix' do
      before do
        result.footnote_suffix = 'foo'
      end

      it { expect(result.footnote_suffix).to eq('foo') }
    end
  end

  describe '#footnote_suffix=' do
    context 'when there is already a suffix' do
      before do
        result.footnote_suffix = 'foo'
      end

      it 'does not set a new suffix' do
        result.footnote_suffix = 'bar'

        expect(result.footnote_suffix).to eq('foo')
      end
    end

    context 'when there is no suffix' do
      it 'does not set a new suffix' do
        result.footnote_suffix = 'bar'

        expect(result.footnote_suffix).to eq('bar')
      end
    end
  end

  describe '#footnote' do
    subject(:result) { build(:duty_option_result, :third_country_tariff) }

    context 'when there is a suffix' do
      let(:expected_footnote) do
        "<p class=\"govuk-body\">\n  A ‘Third country’ duty is the tariff charged where there isn’t a trade agreement or a customs union available. It can also be referred to as the Most Favoured Nation (<abbr title=\"Most Favoured Nation\">MFN</abbr>) rate.\n</p>bar"
      end

      before do
        result.footnote_suffix = 'bar'
      end

      it 'returns the footnote with a suffix' do
        expect(result.footnote).to eq(expected_footnote)
      end
    end

    context 'when there is no suffix' do
      let(:expected_footnote) do
        "<p class=\"govuk-body\">\n  A ‘Third country’ duty is the tariff charged where there isn’t a trade agreement or a customs union available. It can also be referred to as the Most Favoured Nation (<abbr title=\"Most Favoured Nation\">MFN</abbr>) rate.\n</p>"
      end

      it 'returns the footnote' do
        expect(result.footnote).to eq(expected_footnote)
      end
    end
  end
end
