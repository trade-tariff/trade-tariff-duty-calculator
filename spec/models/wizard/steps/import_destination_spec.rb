RSpec.describe Wizard::Steps::ImportDestination do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      import_destination: '',
    ).permit(:import_destination)
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[
          country_of_origin
          trader_scheme
          final_use
          certificate_of_origin
          planned_processing
        ],
      )
    end
  end

  describe '#validations' do
    context 'when import destination is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_destination]).to eq(['Select a destination'])
      end
    end

    context 'when import destination is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          import_destination: 'gb',
        ).permit(:import_destination)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:import_destination]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        import_destination: 'XI',
      ).permit(:import_destination)
    end

    it 'saves the import_destination to the session' do
      step.save

      expect(user_session.import_destination).to eq('XI')
    end

    context 'when importing to XI' do
      it 'sets the commodity source as XI on the session' do
        step.save

        expect(user_session.commodity_source).to eq('xi')
      end
    end

    context 'when importing to GB' do
      let(:attributes) do
        ActionController::Parameters.new(
          import_destination: 'GB',
        ).permit(:import_destination)
      end

      it 'sets the commodity source as UK on the session' do
        step.save

        expect(user_session.commodity_source).to eq('uk')
      end
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    it 'returns country_of_origin_path' do
      expect(
        step.next_step_path,
      ).to eq(
        country_of_origin_path,
      )
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    it 'returns import_date_path' do
      expect(
        step.previous_step_path,
      ).to eq(
        import_date_path,
      )
    end
  end
end
