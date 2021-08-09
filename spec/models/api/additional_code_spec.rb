RSpec.describe Api::AdditionalCode do
  subject(:additional_code) { build(:api_additional_code, :company) }

  it_behaves_like 'a resource that has attributes',
                  id: 'flibble',
                  code: 'C490',
                  description: 'COFCO International Argentina S.A.',
                  formatted_description: 'COFCO International Argentina S.A.'

  describe '#additional_code_type' do
    it { expect(additional_code.additional_code_type).to eq('C') }
  end

  describe '#additional_code_id' do
    it { expect(additional_code.additional_code_id).to eq('490') }
  end
end
