RSpec.describe Steps::Interstitial, :step do
  subject(:step) { described_class.new(user_session) }

  let(:user_session) do
    build(
      :user_session,
      import_destination: import_destination,
      country_of_origin: country_of_origin,
      other_country_of_origin: other_country_of_origin,
      trade_defence: trade_defence,
      planned_processing: planned_processing,
      final_use: final_use,
      trader_scheme: trader_scheme,
    )
  end

  let(:session) { user_session.session }

  let(:import_destination) { 'XI' }
  let(:country_of_origin) { 'GB' }
  let(:other_country_of_origin) { '' }
  let(:trade_defence) { false }
  let(:planned_processing) { 'without_any_processing' }
  let(:final_use) { 'yes' }
  let(:trader_scheme) { 'yes' }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to be_empty
    end
  end

  describe '#next_step_path' do
    it 'returns customs_value_path' do
      expect(
        step.next_step_path,
      ).to eq(
        customs_value_path,
      )
    end
  end

  describe '#previous_step_path' do
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

      context 'when goods are for commercial processing' do
        let(:planned_processing) { 'commercial_processing' }

        it 'returns planned_processing_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            planned_processing_path,
          )
        end
      end

      context 'when goods are for commercial purposes' do
        let(:planned_processing) { 'commercial_purposes' }

        it 'returns no path at all for now' do
          expect(
            step.previous_step_path,
          ).to eq(
            nil,
          )
        end
      end

      context 'when goods are not for final use' do
        let(:final_use) { 'no' }

        it 'returns final_use_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            final_use_path,
          )
        end
      end

      context 'when the trader is not part of the trader scheme' do
        let(:trader_scheme) { 'no' }

        it 'returns trader_scheme_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            trader_scheme_path,
          )
        end
      end
    end
  end
end
