require 'rails_helper'

RSpec.describe Wizard::Steps::CountryOfOrigin do
  subject(:country) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }

  let(:attributes) do
    ActionController::Parameters.new(
      'geographical_area_id' => '',
    ).permit!
  end

  describe '#validations' do
    context 'when geographical_area_id is blank' do
      it 'is not a valid object' do
        expect(country.valid?).to be false
      end

      it 'adds the correct validation error message' do
        country.valid?

        expect(country.errors.messages[:geographical_area_id]).to eq(['Enter a valid origin for this import'])
      end
    end

    context 'when geographical_area_id is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          'geographical_area_id' => '1',
        ).permit!
      end

      it 'is a valid object' do
        expect(country.valid?).to be true
      end

      it 'has no validation errors' do
        country.valid?

        expect(country.errors.messages[:geographical_area_id]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        'geographical_area_id' => '2',
      ).permit!
    end

    it 'saves the geographical_area_id to the session' do
      country.save

      expect(user_session.geographical_area_id).to eq '2'
    end
  end
end
