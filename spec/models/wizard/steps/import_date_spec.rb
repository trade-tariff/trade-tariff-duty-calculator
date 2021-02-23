require 'rails_helper'

RSpec.describe Wizard::Steps::ImportDate do
  subject(:import_date) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      'import_date(3i)' => '12',
      'import_date(2i)' => '12',
      'import_date(1i)' => 1.year.from_now.year.to_s,
    ).permit!
  end

  describe '#validations' do
    context 'when import date is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '',
          'import_date(2i)' => '',
          'import_date(1i)' => '',
        ).permit!
      end

      it 'is not a valid object' do
        expect(import_date.valid?).to be false
      end

      it 'adds the correct validation error message' do
        import_date.valid?

        expect(import_date.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is incomplete' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '',
          'import_date(2i)' => '12',
          'import_date(1i)' => '',
        ).permit!
      end

      it 'is not a valid object' do
        expect(import_date.valid?).to be false
      end

      it 'adds the correct validation error message' do
        import_date.valid?

        expect(import_date.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date contains non numeric characters' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '12',
          'import_date(2i)' => '12',
          'import_date(1i)' => '@@',
        ).permit!
      end

      it 'is not a valid object' do
        expect(import_date.valid?).to be false
      end

      it 'adds the correct validation error message' do
        import_date.valid?

        expect(import_date.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is in the past' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '12',
          'import_date(2i)' => '12',
          'import_date(1i)' => '2001',
        ).permit!
      end

      it 'is not a valid object' do
        expect(import_date.valid?).to be false
      end

      it 'adds the correct validation error message' do
        import_date.valid?

        expect(import_date.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is invalid' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '12',
          'import_date(2i)' => '34',
          'import_date(1i)' => '3000',
        ).permit!
      end

      it 'is not a valid object' do
        expect(import_date.valid?).to be false
      end

      it 'adds the correct validation error message' do
        import_date.valid?

        expect(import_date.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is valid and in future' do
      it 'is a valid object' do
        expect(import_date.valid?).to be true
      end

      it 'has no validation errors' do
        import_date.valid?

        expect(import_date.errors.messages[:import_date]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:expected_date) { Date.parse("#{1.year.from_now.year}-12-12") }

    it 'saves the import_date to the session' do
      import_date.save

      expect(user_session.import_date).to eq(expected_date)
    end
  end
end
