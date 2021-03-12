require 'rails_helper'

RSpec.describe Wizard::Steps::ImportDate do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      'import_date(3i)' => '12',
      'import_date(2i)' => '12',
      'import_date(1i)' => 1.year.from_now.year.to_s,
    ).permit(
      'import_date(3i)',
      'import_date(2i)',
      'import_date(1i)',
    )
  end

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
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '',
          'import_date(2i)' => '',
          'import_date(1i)' => '',
        ).permit(
          'import_date(3i)',
          'import_date(2i)',
          'import_date(1i)',
        )
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is incomplete' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '',
          'import_date(2i)' => '12',
          'import_date(1i)' => '',
        ).permit(
          'import_date(3i)',
          'import_date(2i)',
          'import_date(1i)',
        )
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date contains non numeric characters' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '12',
          'import_date(2i)' => '12',
          'import_date(1i)' => '@@',
        ).permit(
          'import_date(3i)',
          'import_date(2i)',
          'import_date(1i)',
        )
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is in the past' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '12',
          'import_date(2i)' => '12',
          'import_date(1i)' => '2001',
        ).permit(
          'import_date(3i)',
          'import_date(2i)',
          'import_date(1i)',
        )
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is invalid' do
      let(:attributes) do
        ActionController::Parameters.new(
          'import_date(3i)' => '12',
          'import_date(2i)' => '34',
          'import_date(1i)' => '3000',
        ).permit(
          'import_date(3i)',
          'import_date(2i)',
          'import_date(1i)',
        )
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:import_date]).to eq(['Enter a valid future date'])
      end
    end

    context 'when import date is valid and in future' do
      it 'is a valid object' do
        expect(step.valid?).to be true
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
      step.save

      expect(user_session.import_date).to eq(expected_date)
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'returns import_destination_path' do
      expect(
        step.next_step_path(service_choice: service_choice, commodity_code: commodity_code),
      ).to eq(
        import_destination_path(service_choice: service_choice, commodity_code: commodity_code),
      )
    end
  end
end
