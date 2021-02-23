require 'rails_helper'

RSpec.describe Wizard::Steps::CountryOfOrigin do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }

  let(:attributes) do
    ActionController::Parameters.new(
      'geographical_area_id' => '',
    ).permit!
  end

  describe '#validations' do
    context 'when geographical_area_id is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:geographical_area_id]).to eq(['Enter a valid origin for this import'])
      end
    end

    context 'when geographical_area_id is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          'geographical_area_id' => '1',
        ).permit!
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:geographical_area_id]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        'geographical_area_id' => '2',
      ).permit!
    end

    it 'saves the geographical_area_id to the session' do
      step.save

      expect(user_session.geographical_area_id).to eq '2'
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'returns import_destination_path' do
      expect(
        step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
      ).to eq(
        import_destination_path(service_choice: service_choice, commodity_code: commodity_code),
      )
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    let(:session) do
      {
        '2' => 'GB',
        '3' => 'XI',
      }
    end

    context 'when on NI to GB route' do
      it 'returns duty_path' do
        expect(
          step.next_step_path(service_choice: service_choice, commodity_code: commodity_code),
        ).to eq(
          duty_path(service_choice: service_choice, commodity_code: commodity_code),
        )
      end
    end
  end
end
