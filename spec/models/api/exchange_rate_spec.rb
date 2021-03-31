RSpec.describe Api::ExchangeRate, type: :model do
  it_behaves_like 'a resource that has attributes', id: 'GBP',
                                                    rate: 0.8423,
                                                    base_currency: 'EUR',
                                                    applicable_date: '2020-01-22'

  describe '.for' do
    subject(:exchange_rate) { described_class.for(currency) }

    context 'when the currency we specify exists' do
      let(:currency) { 'GBP' }

      it 'returns the exchange rate' do
        expect(exchange_rate.id).to eq(currency)
      end
    end

    context 'when the currency we specify does not exist' do
      let(:currency) { 'SCHMKL' }

      it 'returns nil' do
        expect(exchange_rate).to be_nil
      end
    end
  end
end
