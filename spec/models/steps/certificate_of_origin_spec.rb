RSpec.describe Steps::CertificateOfOrigin do
  subject(:step) do
    build(:certificate_of_origin, user_session: user_session, certificate_of_origin: certificate_of_origin)
  end

  let(:session_attributes) { {} }
  let(:user_session) { build(:user_session, session_attributes) }
  let(:certificate_of_origin) { '' }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[],
      )
    end
  end

  describe '#validations' do
    context 'when certificate of origin answer is blank' do
      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:certificate_of_origin]).to eq(['Select one of the two options'])
      end
    end

    context 'when certificate of origin answer is present' do
      let(:certificate_of_origin) { 'no' }

      it 'is a valid object' do
        expect(step).to be_valid
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:certificate_of_origin]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:certificate_of_origin) { 'yes' }

    it 'saves the certificate_of_origin to the session' do
      step.save

      expect(user_session.certificate_of_origin).to eq('yes')
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    context 'when there is a certificate of origin available' do
      let(:session_attributes) { { 'certificate_of_origin' => 'yes' } }

      it 'returns duty_path' do
        expect(
          step.next_step_path,
        ).to eq(
          duty_path,
        )
      end
    end

    context 'when there is no certificate of origin available' do
      let(:session_attributes) { { 'certificate_of_origin' => 'no' } }

      it 'returns customs_value_path' do
        expect(
          step.next_step_path,
        ).to eq(
          customs_value_path,
        )
      end
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    context 'when final use answer is NO' do
      let(:session_attributes) { { 'final_use' => 'no' } }

      it 'returns final_use_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          final_use_path,
        )
      end
    end

    context 'when trader scheme answer is NO' do
      let(:session_attributes) do
        { 'trader_scheme' => 'no' }
      end

      it 'returns trader_scheme_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          trader_scheme_path,
        )
      end
    end

    context 'when planned processing answer is commercial_purposes' do
      let(:session_attributes) do
        {
          'planned_processing' => 'commercial_purposes',
        }
      end

      it 'returns planned_processing_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          planned_processing_path,
        )
      end
    end
  end
end
