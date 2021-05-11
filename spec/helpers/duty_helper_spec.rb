RSpec.describe DutyHelper do
  before do
    allow(helper).to receive(:user_session).and_return(user_session)
  end

  describe '#commodity_additional_code' do
    context 'when additional code answers have been stored on the session' do
      let(:user_session) { build(:user_session, additional_code: { '103' => 'C999', '105' => 'B111' }) }

      it { expect(helper.commodity_additional_code).to eq('C999, B111') }
    end

    context 'when additional code answers have not been stored on the session' do
      let(:user_session) { build(:user_session) }

      it { expect(helper.commodity_additional_code).to eq('') }
    end
  end
end
