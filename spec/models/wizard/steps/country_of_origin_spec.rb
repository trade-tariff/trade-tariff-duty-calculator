require 'rails_helper'

RSpec.describe Wizard::Steps::CountryOfOrigin do
  subject(:country) { described_class.new(session, attributes) }

  let(:session) { {} }

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

        expect(country.errors.messages[:geographical_area_id]).to eq(['Select a country of dispatch'])
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
    let(:expected_session) do
      {
        Wizard::Steps::CountryOfOrigin::STEP_ID => '2',
      }
    end

    let(:attributes) do
      ActionController::Parameters.new(
        'geographical_area_id' => '2',
      ).permit!
    end

    it 'saves the geographical_area_id to the session' do
      country.save

      expect(country.session).to eq(expected_session)
    end
  end
end
