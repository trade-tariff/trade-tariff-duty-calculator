require 'rails_helper'

RSpec.describe Wizard::Steps::CertificateOfOrigin do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      certificate_of_origin: '',
    ).permit(:certificate_of_origin)
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[
          customs_value
        ],
      )
    end
  end

  describe '#validations' do
    context 'when certificate of origin answer is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:certificate_of_origin]).to eq(['Select one of the two options'])
      end
    end

    context 'when certificate of origin answer is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          certificate_of_origin: 'no',
        ).permit(:certificate_of_origin)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:certificate_of_origin]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        certificate_of_origin: 'yes',
      ).permit(:certificate_of_origin)
    end

    it 'saves the certificate_of_origin to the session' do
      step.save

      expect(user_session.certificate_of_origin).to eq('yes')
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

    context 'when on GB to NI route' do
      context 'when final use answer is NO' do
        let(:session) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'GB',
            'final_use' => 'no',
          }
        end

        it 'returns final_use_path' do
          expect(
            step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
          ).to eq(
            final_use_path(service_choice: service_choice, commodity_code: commodity_code),
          )
        end
      end

      context 'when trader scheme answer is NO' do
        let(:session) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'GB',
            'trader_scheme' => 'no',
          }
        end

        it 'returns trader_scheme_path' do
          expect(
            step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
          ).to eq(
            trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code),
          )
        end
      end
    end
  end
end
