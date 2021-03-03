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
          'final_use' => '0',
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
        'final_use' => '1',
      ).permit(:final_use)
    end

    it 'saves the trader_scheme to the session' do
      step.save

      expect(user_session.final_use).to eq('1')
    end
  end

  xdescribe '#next_step_path' do
    it 'needs to be implemented' do
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }
    let(:session) do
      {
        'import_destination' => 'XI',
        'country_of_origin' => 'GB',
        'trader_scheme' => '1',
      }
    end

    context 'when on GB to NI route' do
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
