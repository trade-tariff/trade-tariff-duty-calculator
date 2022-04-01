RSpec.describe Steps::Stopping, :step, :user_session do
  describe '#previous_step_path' do
    subject(:step) { build(:stopping).previous_step_path }

    context 'when there are document codes' do
      let(:user_session) { build(:user_session, :with_commodity_information, :with_document_codes) }

      it { is_expected.to eq(document_codes_path('105')) }
    end

    context 'when there are no document codes' do
      let(:user_session) { build(:user_session, :with_commodity_information) }

      it { is_expected.to eq(import_date_path(referred_service: user_session.referred_service, commodity_code: user_session.commodity_code)) }
    end
  end
end
