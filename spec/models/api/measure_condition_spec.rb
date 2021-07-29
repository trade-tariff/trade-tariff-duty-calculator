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
                  document_code: '',
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
end
