require 'rails_helper'

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
          customs_value
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
        import_destination: 'ni',
      ).permit(:import_destination)
    end

    it 'saves the import_date to the session' do
      step.save

      expect(user_session.import_destination).to eq('ni')
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'returns country_of_origin_path' do
      expect(
        step.next_step_path(service_choice: service_choice, commodity_code: commodity_code),
      ).to eq(
        country_of_origin_path(service_choice: service_choice, commodity_code: commodity_code),
      )
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'returns import_date_path' do
      expect(
        step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
      ).to eq(
        import_date_path(service_choice: service_choice, commodity_code: commodity_code),
      )
    end
  end
end
