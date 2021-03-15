require 'rails_helper'

RSpec.describe Wizard::Steps::Confirmation do
  subject(:step) { described_class.new(user_session) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(%w[])
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    xit 'to be added' do
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    context 'when on GB to NI route' do
      before do
        allow(user_session).to receive(:gb_to_ni_route?).and_return(true)
      end

      it 'returns measure_amount_path' do
        expect(
          step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
        ).to eq(
          measure_amount_path(service_choice: service_choice, commodity_code: commodity_code),
        )
      end
    end
  end
end
