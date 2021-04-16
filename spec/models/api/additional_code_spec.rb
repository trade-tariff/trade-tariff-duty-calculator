RSpec.describe Api::AdditionalCode do
  subject(:additional_code) do
    described_class.new(
      code: code,
      description: 'COFCO International Argentina S.A.',
      formatted_description: 'COFCO International Argentina S.A.',
    )
  end

  let(:code) { 'F111' }

  it_behaves_like 'a resource that has attributes', code: 'C490',
                                                    description: 'COFCO International Argentina S.A.',
                                                    formatted_description: 'COFCO International Argentina S.A.'

  describe '#additional_code_type' do
    it { expect(additional_code.additional_code_type).to eq('F') }
  end

  describe '#additional_code_id' do
    it { expect(additional_code.additional_code_id).to eq('111') }
  end

  describe '#company_defensive_code?' do
    context 'when the additional_code_type is a company identifying code type' do
      let(:code) { 'A111' }

      it { is_expected.to be_company_defensive_code }
    end

    context 'when the additional_code_type is not a company identifying code type' do
      let(:code) { 'X111' }

      it { is_expected.not_to be_company_defensive_code }
    end
  end

  describe '#no_company_defensive_code?' do
    context 'when the additional_code_type is a company identifying code type' do
      let(:code) { 'A111' }

      it { is_expected.not_to be_no_company_defensive_code }
    end

    context 'when the additional_code_type is not a company identifying code type' do
      let(:code) { 'X111' }

      it { is_expected.to be_no_company_defensive_code }
    end
  end
end
