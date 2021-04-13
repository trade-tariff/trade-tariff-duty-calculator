RSpec.describe Wizard::Steps::PlannedProcessing do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      'planned_processing' => '',
    ).permit(:planned_processing)
  end

  describe '#validations' do
    context 'when planned processing answer is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:planned_processing]).to eq(['Select one of the available options'])
      end
    end

    context 'when planned processing answer is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          'planned_processing' => 'without_any_processing',
        ).permit(:planned_processing)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:planned_processing]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        'planned_processing' => 'without_any_processing',
      ).permit(:planned_processing)
    end

    it 'saves the planned_processing to the session' do
      step.save

      expect(user_session.planned_processing).to eq('without_any_processing')
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:answer) { 'without_any_processing' }
    let(:session) do
      {
        'answers' => {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
          'trader_scheme' => 'yes',
          'final_use' => 'yes',
          'planned_processing' => answer,
        },
      }
    end

    context 'when on GB to NI route and answer is not commercial_purposes' do
      it 'returns duty_path' do
        expect(
          step.next_step_path,
        ).to eq(
          duty_path,
        )
      end
    end

    context 'when on GB to NI route and answer is commercial_purposes' do
      let(:answer) { 'commercial_purposes' }

      it 'returns duty_path' do
        expect(
          step.next_step_path,
        ).to eq(
          certificate_of_origin_path,
        )
      end
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:session) do
      {
        'answers' => {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
          'trader_scheme' => 'yes',
        },
      }
    end

    context 'when on GB to NI route' do
      it 'returns country_of_origin_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          final_use_path,
        )
      end
    end
  end
end
