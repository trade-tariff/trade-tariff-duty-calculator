RSpec.describe UkimsHelper, :user_session do
  before do
    allow(UserSession).to receive(:get).and_return(user_session)
    allow(helper).to receive(:user_session).and_return(user_session)
  end

  let(:user_session) do
    build(
      :user_session,
      import_date:,
    )
  end

  describe '#uk_internal_market_scheme' do
    context 'when the import date is after the cut off' do
      let(:import_date) { Date.new(2023, 9, 30).strftime('%Y-%m-%d') }

      it 'returns the corect string when the import_date is after cut off date' do
        expect(helper.uk_internal_market_scheme).to eq('UK Internal Market Scheme')
      end
    end

    context 'when the import date is before the cut off' do
      let(:import_date) { Date.new(2023, 9, 29).strftime('%Y-%m-%d') }

      it 'returns the corect string when the import_date is after cut off date' do
        expect(helper.uk_internal_market_scheme).to eq('UK Trader Scheme')
      end
    end
  end

  describe '#ukims_annual_turnover' do
    context 'when the import date is after the cut off' do
      let(:import_date) { Date.new(2023, 9, 30).strftime('%Y-%m-%d') }

      it 'returns the corect string when the import_date is after cut off date' do
        expect(helper.ukims_annual_turnover).to eq('£2,000,000')
      end
    end

    context 'when the import date is before the cut off' do
      let(:import_date) { Date.new(2023, 9, 29).strftime('%Y-%m-%d') }

      it 'returns the corect string when the import_date is after cut off date' do
        expect(helper.ukims_annual_turnover).to eq('£500,000')
      end
    end
  end
end
