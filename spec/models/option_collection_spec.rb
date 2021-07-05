RSpec.describe OptionCollection do
  subject(:collection) { described_class.new(options) }

  let(:options) do
    [
      third_country_tariff_option,
      tariff_preference_option,
      cheapest_tariff_preference_option,
    ]
  end

  let(:third_country_tariff_option) do
    build(
      :duty_option_result,
      :third_country_tariff,
      value: 0.2,
    )
  end
  let(:tariff_preference_option) do
    build(
      :duty_option_result,
      :tariff_preference,
      value: 100,
    )
  end
  let(:cheapest_tariff_preference_option) do
    build(
      :duty_option_result,
      :tariff_preference,
      value: 0.5,
    )
  end

  describe '#tariff_preference_options' do
    it { expect(collection.tariff_preference_options).to eq([tariff_preference_option, cheapest_tariff_preference_option]) }
  end

  describe '#cheapest_tariff_preference_option' do
    it { expect(collection.cheapest_tariff_preference_option).to eq(cheapest_tariff_preference_option) }
  end

  describe '#third_country_tariff_option' do
    it { expect(collection.third_country_tariff_option).to eq(third_country_tariff_option) }
  end
end
