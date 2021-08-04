RSpec.describe Api::MeasureCondition do
  subject(:measure_condition) do
    described_class.new(
      condition_measurement_unit_code: condition_measurement_unit_code,
      condition_monetary_unit_code: condition_monetary_unit_code,
    )
  end

  let(:condition_measurement_unit_code) { nil }
  let(:condition_monetary_unit_code) { nil }

  it_behaves_like 'a resource that has attributes',
                  id: 'flibble',
                  condition_code: 'B',
                  condition: 'B: Presentation of a certificate/licence/document',
                  requirement: nil,
                  action: 'The entry into free circulation is not allowed',
                  duty_expression: '',
                  condition_duty_amount: nil,
                  condition_monetary_unit_code: nil,
                  monetary_unit_abbreviation: nil,
                  condition_measurement_unit_code: nil,
                  condition_measurement_unit_qualifier_code: nil,
                  measure_condition_components: []

  describe '#expresses_unit?' do
    it 'returns false' do
      expect(measure_condition).not_to be_expresses_unit
    end

    context 'when condition_monetary_unit_code is present' do
      let(:condition_monetary_unit_code) { 'EUR' }

      it 'returns true' do
        expect(measure_condition).to be_expresses_unit
      end
    end

    context 'when condition_measurement_unit_code is present' do
      let(:condition_measurement_unit_code) { 'DTN' }

      it 'returns true' do
        expect(measure_condition).to be_expresses_unit
      end
    end
  end

  describe '#expresses_document?' do
    subject(:measure_condition) { described_class.new(condition_code: condition_code) }

    context 'when the condition_code is a document condition code' do
      let(:condition_code) { 'I' }

      it { is_expected.to be_expresses_document }
    end

    context 'when the condition_code is not a document condition code' do
      let(:condition_code) { 'V' }

      it { is_expected.not_to be_expresses_document }
    end
  end

  describe '#applicable?' do
    shared_examples 'an applicable measure condition' do |action_code|
      subject(:measure_condition) { described_class.new(action_code: action_code) }

      context 'when the measure condition has an action code which requires we apply the duty amount' do
        it { is_expected.to be_applicable }
      end
    end

    it_behaves_like 'an applicable measure condition', '01'
    it_behaves_like 'an applicable measure condition', '24'
    it_behaves_like 'an applicable measure condition', '25'
    it_behaves_like 'an applicable measure condition', '26'
    it_behaves_like 'an applicable measure condition', '27'
    it_behaves_like 'an applicable measure condition', '28'
    it_behaves_like 'an applicable measure condition', '29'
    it_behaves_like 'an applicable measure condition', '34'
    it_behaves_like 'an applicable measure condition', '36'

    context 'when the measure condition has an action which does not require we apply the duty amount' do
      subject(:measure_condition) { described_class.new(action_code: 'foo') }

      it { is_expected.not_to be_applicable }
    end
  end

  describe '#document_code' do
    subject(:measure_condition) { described_class.new('document_code' => document_code) }

    context 'when the measure condition has a document code' do
      let(:document_code) { 'C990' }

      it { expect(measure_condition.document_code).to eq('C990') }
    end

    context 'when the measure condition does not have a document code' do
      let(:document_code) { '' }

      it { expect(measure_condition.document_code).to eq('None') }
    end
  end

  describe '#certificate_description' do
    subject(:measure_condition) { described_class.new('document_code' => document_code, certificate_description: '') }

    context 'when the measure condition has a document code' do
      let(:document_code) { 'C990' }

      it { expect(measure_condition.document_code).to eq('C990') }
    end

    context 'when the measure condition does not have a document code' do
      let(:document_code) { '' }

      it { expect(measure_condition.document_code).to eq('None') }
    end
  end
end
