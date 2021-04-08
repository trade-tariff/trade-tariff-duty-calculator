RSpec.describe Api::MeasureType do
  it_behaves_like 'a resource that has attributes', description: 'Phytosanitary Certificate (import)',
                                                    national: nil,
                                                    measure_type_series_id: 'B',
                                                    id: '360'

  it_behaves_like 'a resource that has an enum', :measure_type_series_id, {
    applicable_duty: %w[C],
    anti_dumping_and_countervailing_duty: %w[D],
    additional_duty: %w[F],
    countervailing_charge_duty: %w[J],
    unit_price_duty: %w[M],
  }

  it_behaves_like 'a resource that has an enum', :id, {
    third_country: %w[103 105],
    tariff_preference: %w[142],
    autonomous_suspension: %w[112],
    autonomous_end_use_suspension: %w[115],
    certain_category_goods_suspension: %w[117],
    airworthiness_suspension: %w[119],
  }

  describe '#option' do
    subject(:measure_type) { described_class.new(id: id) }

    context 'when their is a corresponding option for the id' do
      let(:id) { '142' }

      it { expect(measure_type.option).to eq(DutyOptions::TariffPreference) }
    end

    context 'when their is not a corresponding option' do
      let(:id) { '999' }

      it { expect(measure_type.option).to be_nil }
    end
  end
end
