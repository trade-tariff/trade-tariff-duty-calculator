RSpec.describe AdValoremExpressionEvaluator do
  subject(:evaluator) do
    described_class.new(component, total_amount)
  end

  let(:component) { Api::MeasureComponent.new(duty_amount: duty_amount) }
  let(:total_amount) { 1000.0 }

  context 'when the duty amount is 1000.0' do
    let(:expected_evaluation) do
      {
        calculation: '8.0% * £1000.0',
        formatted_value: '£80.0',
        value: 80.0,
      }
    end

    let(:duty_amount) { 8.0 }

    it 'returns a properly calculated evaluation' do
      expect(evaluator.call).to eq(expected_evaluation)
    end
  end

  context 'when the duty amount is 0.0' do
    let(:expected_evaluation) do
      {
        calculation: '0.0% * £1000.0',
        formatted_value: '£0.0',
        value: 0.0,
      }
    end

    let(:duty_amount) { 0.0 }

    it 'returns a properly calculated evaluation' do
      expect(evaluator.call).to eq(expected_evaluation)
    end
  end
end
