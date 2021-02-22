require 'rails_helper'

RSpec.describe Wizard::Steps::ImportDestination do
  subject(:country) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      'import_destination' => '',
    ).permit!
  end

  describe '#validations' do
    context 'when import destination is blank' do
      it 'is not a valid object' do
        expect(country.valid?).to be false
      end

      it 'adds the correct validation error message' do
        country.valid?

        expect(country.errors.messages[:import_destination]).to eq(['Select a destination'])
      end
    end

    context 'when import destination is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_destination' => 'gb',
        ).permit!
      end

      it 'is a valid object' do
        expect(country.valid?).to be true
      end

      it 'has no validation errors' do
        country.valid?

        expect(country.errors.messages[:import_destination]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        'import_destination' => 'ni',
      ).permit!
    end

    it 'saves the import_date to the session' do
      country.save

      expect(user_session.import_destination).to eq('ni')
    end
  end
end
