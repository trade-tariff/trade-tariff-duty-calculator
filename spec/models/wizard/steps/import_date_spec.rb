RSpec.describe Wizard::Steps::ImportDate do
  subject(:step) do
    build(
      :import_date,
      user_session: user_session,
      date_3i: date_3i,
      date_2i: date_2i,
      date_1i: date_1i,
    )
  end

  let(:user_session) { build(:user_session) }
  let(:session) { user_session.session }
  let(:date_3i) { '12' }
  let(:date_2i) { '12' }
  let(:date_1i) { 1.year.from_now.year.to_s }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[
          import_destination
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
    context 'when import date is blank' do
      let(:date_3i) { '' }
      let(:date_2i) { '' }
      let(:date_1i) { '' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid date, no earlier than 1st January 2021'])
      end
    end

    context 'when import date is incomplete' do
      let(:date_3i) { '' }
      let(:date_2i) { '12' }
      let(:date_1i) { '' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid date, no earlier than 1st January 2021'])
      end
    end

    context 'when import date contains non numeric characters' do
      let(:date_3i) { '12' }
      let(:date_2i) { '12' }
      let(:date_1i) { '@@' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid date, no earlier than 1st January 2021'])
      end
    end

    context 'when import date is in the past, earlier than 1st Jan 2021' do
      let(:date_3i) { '31' }
      let(:date_2i) { '12' }
      let(:date_1i) { '2020' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid date, no earlier than 1st January 2021'])
      end
    end

    context 'when import date is in the past, but not earlier than 1st Jan 2021' do
      let(:date_3i) { '1' }
      let(:date_2i) { '1' }
      let(:date_1i) { '2021' }

      it 'is a valid object' do
        expect(step).to be_valid
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:import_date]).to be_empty
      end
    end

    context 'when import date is invalid' do
      let(:date_3i) { '12' }
      let(:date_2i) { '34' }
      let(:date_1i) { '3000' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid date, no earlier than 1st January 2021'])
      end
    end

    context 'when import date is valid and in future' do
      it 'is a valid object' do
        expect(step).to be_valid
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:import_date]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:expected_date) { Date.parse("#{1.year.from_now.year}-12-12") }

    it 'saves the import_date to the session' do
      expect { step.save }.to change(user_session, :import_date).from(nil).to(expected_date)
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    it 'returns import_destination_path' do
      expect(
        step.next_step_path,
      ).to eq(
        import_destination_path,
      )
    end
  end
end
