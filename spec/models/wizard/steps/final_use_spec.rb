require 'rails_helper'

RSpec.describe Wizard::Steps::FinalUse do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      'final_use' => '',
    ).permit(:final_use)
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[
          certificate_of_origin
          planned_processing
        ],
      )
    end
  end

  describe '#validations' do
    context 'when final use answer is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:final_use]).to eq(['Select one of the two options'])
      end
    end

    context 'when final use answer is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          'final_use' => 'no',
        ).permit(:final_use)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:final_use]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        'final_use' => 'yes',
      ).permit(:final_use)
    end

    it 'saves the trader_scheme to the session' do
      step.save

      expect(user_session.final_use).to eq('yes')
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    context 'when on GB to NI route and final use answer is yes' do
      let(:session) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
          'trader_scheme' => 'yes',
          'final_use' => 'yes',
        }
      end

      it 'returns planned_processing_path' do
        expect(
          step.next_step_path(service_choice: service_choice, commodity_code: commodity_code),
        ).to eq(
          planned_processing_path(service_choice: service_choice, commodity_code: commodity_code),
        )
      end
    end

    context 'when on GB to NI route and final use answer is no' do
      let(:session) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
          'trader_scheme' => 'yes',
          'final_use' => 'no',
        }
      end

      it 'returns certificate_of_origin_path' do
        expect(
          step.next_step_path(service_choice: service_choice, commodity_code: commodity_code),
        ).to eq(
          certificate_of_origin_path(service_choice: service_choice, commodity_code: commodity_code),
        )
      end
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    context 'when on GB to NI route' do
      let(:session) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
          'trader_scheme' => 'yes',
        }
      end

      it 'returns country_of_origin_path' do
        expect(
          step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
        ).to eq(
          trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code),
        )
      end
    end
  end
end
