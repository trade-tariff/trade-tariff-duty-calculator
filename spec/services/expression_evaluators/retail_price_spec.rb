RSpec.describe ExpressionEvaluators::RetailPrice, :user_session do
  subject(:evaluator) { described_class.new(measure, measure_component) }

  let(:measure) { build(:measure, :excise) }
  let(:measure_component) { build(:measure_component, :with_retail_price_measure_units) }
  let(:user_session) { build(:user_session, :with_retail_price_measure_amount, commodity_code: '0103921100') }

  let(:expected_evaluation) do
    {
      calculation: '16.50% * £1,000.00',
      value: 165.0,
      formatted_value: '£165.00',
    }
  end

  it { expect(evaluator.call).to eq(expected_evaluation) }
end
