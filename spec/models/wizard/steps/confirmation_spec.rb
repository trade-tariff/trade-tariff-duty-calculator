RSpec.describe Wizard::Steps::Confirmation do
  subject(:step) { described_class.new(user_session) }

  let(:user_session) { build(:user_session) }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(%w[])
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    it 'return duty path' do
      expect(
        step.next_step_path,
      ).to eq(
        duty_path,
      )
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    context 'when there are measure amounts on the session' do
      let(:measure_amount) do
        {
          'dtn' => 1,
        }
      end

      before do
        allow(user_session).to receive(:measure_amount).and_return(measure_amount)
      end

      it 'returns measure_amount_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          measure_amount_path,
        )
      end
    end

    context 'when there are no measure amounts on the session' do
      before do
        allow(user_session).to receive(:measure_amount).and_return({})
      end

      it 'returns measure_amount_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          customs_value_path,
        )
      end
    end
  end
end
