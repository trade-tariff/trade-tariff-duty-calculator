RSpec.describe Api::MonetaryExchangeRate, type: :model do
  it_behaves_like 'a resource that has attributes',
                  id: 'flibble',
                  child_monetary_unit_code: 'GBP',
                  exchange_rate: 0.7298,
                  operation_date: nil,
                  validity_start_date: '2016-01-01T00:00:00.000Z'

  describe '.for' do
    context 'when the currency we specify exists' do
      let(:currency) { 'GBP' }

      it 'returns the latest exchange rate' do
        expect(described_class.for(currency).as_json).to eq(
          'attributes' => {
            'meta' => nil,
            'id' => nil,
            'child_monetary_unit_code' => 'GBP',
            'exchange_rate' => '0.8571',
            'operation_date' => '2021-06-29',
            'validity_start_date' => '2021-07-01T00:00:00.000Z',
          },
        )
      end
    end

    context 'when the currency we specify does not exist' do
      let(:currency) { 'SCHMKL' }

      it { expect(described_class.for(currency).as_json).to be_nil }
    end
  end
end
