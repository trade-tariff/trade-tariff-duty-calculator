RSpec.describe Api::MeasureConditionComponent do
  subject(:component) { described_class.new }

  it { is_expected.to be_a(Api::BaseComponent) }
end
