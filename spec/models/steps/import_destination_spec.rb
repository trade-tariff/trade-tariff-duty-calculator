RSpec.describe Steps::ImportDestination, :step, :user_session do
  subject(:step) { build(:import_destination, user_session: user_session, import_destination: import_destination) }

  let(:user_session) { build(:user_session, session_attributes) }
  let(:session_attributes) { {} }
  let(:import_destination) { '' }

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
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_destination]).to eq(['Select a destination'])
      end
    end

    context 'when import destination is present' do
      let(:import_destination) { 'gb' }

      it 'is a valid object' do
        expect(step).to be_valid
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:import_destination]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:import_destination) { 'XI' }

    it 'saves the import_destination to the session' do
      expect { step.save }.to change(user_session, :import_destination).from(nil).to('XI')
    end

    context 'when importing to XI' do
      it 'sets the commodity source as XI on the session' do
        expect { step.save }.to change(user_session, :commodity_source).from(nil).to('xi')
      end
    end

    context 'when importing to GB' do
      let(:import_destination) { 'GB' }

      it 'sets the commodity source as UK on the session' do
        expect { step.save }.to change(user_session, :commodity_source).from(nil).to('uk')
      end
    end
  end

  describe '#next_step_path' do
    it 'returns country_of_origin_path' do
      expect(
        step.next_step_path,
      ).to eq(
        country_of_origin_path,
      )
    end
  end

  describe '#previous_step_path' do
    let(:session_attributes) do
      {
        'commodity_code' => '100000000',
        'referred_service' => 'uk',
      }
    end

    it 'returns import_date_path' do
      expect(
        step.previous_step_path,
      ).to eq(
        import_date_path(
          commodity_code: '100000000',
          referred_service: 'uk',
        ),
      )
    end
  end
end
