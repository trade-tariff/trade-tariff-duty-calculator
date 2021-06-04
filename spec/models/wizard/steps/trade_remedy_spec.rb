RSpec.describe Wizard::Steps::TradeRemedy do
  subject(:step) { described_class.new(user_session) }

  let(:user_session) do
    build(
      :user_session,
      import_destination: import_destination,
      country_of_origin: country_of_origin,
      other_country_of_origin: other_country_of_origin,
      trade_defence: trade_defence,
    )
  end

  let(:session) { user_session.session }

  let(:import_destination) { 'XI' }
  let(:country_of_origin) { 'GB' }
  let(:other_country_of_origin) { '' }
  let(:trade_defence) { false }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to be_empty
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    it 'returns customs_value_path' do
      expect(
        step.next_step_path,
      ).to eq(
        customs_value_path,
      )
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    context 'when on GB to NI route' do
      it 'returns country_of_origin_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          country_of_origin_path,
        )
      end
    end

    context 'when on RoW to NI route' do
      let(:import_destination) { 'XI' }
      let(:country_of_origin) { 'OTHER' }
      let(:other_country_of_origin) { 'AR' }

      context 'when there is a trade defence in place' do
        let(:trade_defence) { true }

        it 'returns customs_value_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            country_of_origin_path,
          )
        end
      end
    end
  end
end
