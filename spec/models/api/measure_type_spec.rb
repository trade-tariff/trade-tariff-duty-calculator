RSpec.describe Api::MeasureType do
  subject(:measure_type) do
    described_class.new(
      description: description,
      national: national,
      measure_type_series_id: measure_type_series_id,
      id: id,
    )
  end

  let(:description) { 'Tariff preference' }
  let(:national) { true }
  let(:measure_type_series_id) { 'C' }
  let(:id) { '142' }

  it_behaves_like 'a resource that has attributes', description: 'Phytosanitary Certificate (import)',
                                                    national: nil,
                                                    measure_type_series_id: 'B',
                                                    id: '360'

  describe '#applicable_duty?' do
    context 'when set measure_type_series_id is C' do
      let(:measure_type_series_id) { 'C' }

      it { is_expected.to be_applicable_duty }
    end

    context 'when set measure_type_series_id is not C' do
      let(:measure_type_series_id) { 'X' }

      it { is_expected.not_to be_applicable_duty }
    end
  end

  describe '#anti_dumping_and_countervailing_duty?' do
    context 'when set measure_type_series_id is D' do
      let(:measure_type_series_id) { 'D' }

      it { is_expected.to be_anti_dumping_and_countervailing_duty }
    end

    context 'when set measure_type_series_id is not D' do
      let(:measure_type_series_id) { 'X' }

      it { is_expected.not_to be_anti_dumping_and_countervailing_duty }
    end
  end

  describe '#additional_duty?' do
    context 'when set measure_type_series_id is F' do
      let(:measure_type_series_id) { 'F' }

      it { is_expected.to be_additional_duty }
    end

    context 'when set measure_type_series_id is not F' do
      let(:measure_type_series_id) { 'X' }

      it { is_expected.not_to be_additional_duty }
    end
  end

  describe '#countervailing_charge_duty?' do
    context 'when set measure_type_series_id is J' do
      let(:measure_type_series_id) { 'J' }

      it { is_expected.to be_countervailing_charge_duty }
    end

    context 'when set measure_type_series_id is not J' do
      let(:measure_type_series_id) { 'X' }

      it { is_expected.not_to be_countervailing_charge_duty }
    end
  end

  describe '#unit_price_duty?' do
    context 'when set measure_type_series_id is M' do
      let(:measure_type_series_id) { 'M' }

      it { is_expected.to be_unit_price_duty }
    end

    context 'when set measure_type_series_id is not M' do
      let(:measure_type_series_id) { 'X' }

      it { is_expected.not_to be_unit_price_duty }
    end
  end

  describe '#third_country?' do
    it 'returns false' do
      expect(measure_type).not_to be_third_country
    end

    context 'when it is a 3rd country measure type' do
      let(:id) { '103' }

      it 'returns true' do
        expect(measure_type).to be_third_country
      end
    end
  end
end
