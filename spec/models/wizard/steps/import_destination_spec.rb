require 'rails_helper'

RSpec.describe Wizard::Steps::ImportDestination do
  subject(:import_destination) { described_class.new(session, attributes) }

  let(:session) { {} }
  let(:attributes) do
    ActionController::Parameters.new(
      'import_destination' => '',
    ).permit!
  end

  describe '#validations' do
    context 'when import destination is blank' do
      it 'is not a valid object' do
        expect(import_destination.valid?).to be false
      end

      it 'adds the correct validation error message' do
        import_destination.valid?

        expect(import_destination.errors.messages[:import_destination]).to eq(['Select a destination'])
      end
    end

    context 'when import destination is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_destination' => '1',
        ).permit!
      end

      it 'is a valid object' do
        expect(import_destination.valid?).to be true
      end

      it 'has no validation errors' do
        import_destination.valid?

        expect(import_destination.errors.messages[:import_destination]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:expected_session) do
      {
        Wizard::Steps::ImportDestination::STEP_ID => '2',
      }
    end

    let(:attributes) do
      ActionController::Parameters.new(
        'import_destination' => '2',
      ).permit!
    end

    it 'saves the import_date to the session' do
      import_destination.save

      expect(import_destination.session).to eq(expected_session)
    end
  end
end
