RSpec.describe Api::ExchangeRate, type: :model do
  it_behaves_like 'a resource that has attributes', id: '1',
                                                    rate: 0.8423,
                                                    base_currency: 'EUR',
                                                    applicable_date: '2020-01-22'
end
