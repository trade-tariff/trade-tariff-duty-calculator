require 'rails_helper'

RSpec.describe Wizard::Steps::TraderScheme do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      trader_scheme: '',
    ).permit(:trader_scheme)
  end

  describe '#validations' do
    context 'when trader scheme answer is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:trader_scheme]).to eq(['Select one of the two options'])
      end
    end

    context 'when trader scheme answer is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          trader_scheme: '0',
        ).permit(:trader_scheme)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:trader_scheme]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        trader_scheme: '1',
      ).permit(:trader_scheme)
    end

    it 'saves the trader_scheme to the session' do
      step.save

      expect(user_session.trader_scheme).to eq('1')
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
        '2' => 'XI',
        '3' => 'GB',
      }
    end

    context 'when on GB to NI route' do
      it 'returns country_of_origin_path' do
        expect(
          step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
        ).to eq(
          country_of_origin_path(service_choice: service_choice, commodity_code: commodity_code),
        )
      end
    end
  end
end
