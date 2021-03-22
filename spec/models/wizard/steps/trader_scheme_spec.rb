RSpec.describe Wizard::Steps::TraderScheme do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      trader_scheme: '',
    ).permit(:trader_scheme)
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[
          final_use
          certificate_of_origin
          planned_processing
        ],
      )
    end
  end

  describe '#validations' do
    context 'when trader scheme answer is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:trader_scheme]).to eq(['Select one of the two options'])
      end
    end

    context 'when trader scheme answer is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          trader_scheme: 'no',
        ).permit(:trader_scheme)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:trader_scheme]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        trader_scheme: 'yes',
      ).permit(:trader_scheme)
    end

    it 'saves the trader_scheme to the session' do
      step.save

      expect(user_session.trader_scheme).to eq('yes')
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:answer) { 'yes' }
    let(:session) do
      {
        'answers' => {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
          'trader_scheme' => answer,
        },
      }
    end

    context 'when on GB to NI route and answer is yes' do
      it 'returns country_of_origin_path' do
        expect(
          step.next_step_path,
        ).to eq(
          final_use_path,
        )
      end
    end

    context 'when on GB to NI route and answer is no' do
      let(:answer) { 'no' }

      it 'returns country_of_origin_path' do
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
        },
      }
    end

    context 'when on GB to NI route' do
      it 'returns country_of_origin_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          country_of_origin_path,
        )
      end
    end
  end
end
