RSpec.describe Steps::Interstitial, :step, :user_session do
  subject(:step) { described_class.new }

  let(:user_session) { build(:user_session) }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it { expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to be_empty }
  end

  describe '#next_step_path' do
    it { expect(step.next_step_path).to eq(customs_value_path) }
  end

  describe '#previous_step_path' do
    context 'when on GB to NI route' do
      let(:user_session) { build(:user_session, :with_gb_to_ni_route) }

      it { expect(step.previous_step_path).to eq(country_of_origin_path) }
    end

    context 'when on the ROW to NI route and there is a trade defence in place' do
      let(:user_session) { build(:user_session, :with_row_to_ni_route, trade_defence: true) }

      it { expect(step.previous_step_path).to eq(country_of_origin_path) }
    end

    context 'when on the ROW to NI route and goods are for commercial processing' do
      let(:user_session) { build(:user_session, :with_row_to_ni_route, planned_processing: 'commercial_purposes') }

      it { expect(step.previous_step_path).to eq(planned_processing_path) }
    end

    context 'when on the ROW to NI route and goods are not for final use' do
      let(:user_session) { build(:user_session, :with_row_to_ni_route, final_use: 'no') }

      it { expect(step.previous_step_path).to eq(final_use_path) }
    end

    context 'when on the ROW to NI route and the trader is not part of the trusted trader scheme' do
      let(:user_session) { build(:user_session, :with_row_to_ni_route, trader_scheme: 'no') }

      it { expect(step.previous_step_path).to eq(trader_scheme_path) }
    end
  end
end
