require 'rails_helper'

RSpec.describe Wizard::Steps::PlannedProcessing do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
        'planned_processing' => '',
        ).permit(:planned_processing)
  end

  describe '#validations' do
    context 'when planned processing answer is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:planned_processing]).to eq(['Please select an option'])
      end
    end

    context 'when planned processing answer is present' do
      let(:attributes) do
        ActionController::Parameters.new(
            'planned_processing' => '0',
            ).permit(:planned_processing)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:planned_processing]).to be_empty
      end
    end
  end

  xdescribe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
          'planned_processing' => '1',
          ).permit(:planned_processing)
    end

    it 'saves the planned_processing to the session' do
      step.save

      expect(user_session.planned_processing).to eq('1')
    end
  end

  xdescribe '#next_step_path' do
    it 'needs to be implemented' do
    end
  end

  xdescribe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }
    let(:session) do
      {
          '2' => 'XI',
          '3' => 'GB',
          '5' => '1',
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
