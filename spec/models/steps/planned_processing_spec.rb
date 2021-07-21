RSpec.describe Steps::PlannedProcessing, :step do
  subject(:step) { build(:planned_processing, user_session: user_session, planned_processing: planned_processing) }

  let(:session_attributes) { {} }
  let(:user_session) { build(:user_session, session_attributes) }
  let(:planned_processing) { '' }

  describe '#validations' do
    context 'when planned processing answer is blank' do
      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:planned_processing]).to eq(['Select one of the available options'])
      end
    end

    context 'when planned processing answer is present' do
      let(:planned_processing) { 'without_any_processing' }

      it 'is a valid object' do
        expect(step).to be_valid
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:planned_processing]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:planned_processing) { 'without_any_processing' }

    it 'saves the planned_processing to the session' do
      expect { step.save }.to change(user_session, :planned_processing).from(nil).to('without_any_processing')
    end
  end

  describe '#next_step_path' do
    let(:answer) { 'without_any_processing' }
    let(:session_attributes) do
      {
        'import_destination' => 'XI',
        'country_of_origin' => 'GB',
        'planned_processing' => answer,
      }
    end

    context 'when on GB to NI route' do
      context 'when the answer is not commercial_purposes' do
        let(:answer) { 'without_any_processing' }

        it 'returns duty_path' do
          expect(
            step.next_step_path,
          ).to eq(
            duty_path,
          )
        end
      end

      context 'when the answer is commercial_purposes' do
        let(:answer) { 'commercial_purposes' }

        it 'returns certificate_of_origin_path' do
          expect(
            step.next_step_path,
          ).to eq(
            certificate_of_origin_path,
          )
        end
      end
    end

    context 'when on RoW to NI route' do
      context 'when the answer is commercial_processing' do
        let(:answer) { 'commercial_processing' }

        let(:session_attributes) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'OTHER',
            'other_country_of_origin' => 'AR',
            'planned_processing' => answer,
          }
        end

        it 'returns interstitial_path' do
          expect(
            step.next_step_path,
          ).to eq(
            customs_value_path,
          )
        end
      end

      context 'when the answer is annual_turnover' do
        let(:answer) { 'annual_turnover' }

        let(:session_attributes) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'OTHER',
            'other_country_of_origin' => 'AR',
            'planned_processing' => answer,
          }
        end

        it 'returns customs_value_path' do
          expect(
            step.next_step_path,
          ).to eq(
            customs_value_path,
          )
        end
      end

      context 'when the answer is without_any_processing' do
        let(:answer) { 'without_any_processing' }

        let(:session_attributes) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'OTHER',
            'other_country_of_origin' => 'AR',
            'planned_processing' => answer,
          }
        end

        it 'returns customs_value_path' do
          expect(
            step.next_step_path,
          ).to eq(
            customs_value_path,
          )
        end
      end

      context 'when the answer is commercial_purposes' do
        let(:answer) { 'commercial_purposes' }

        let(:session_attributes) do
          {
            'import_destination' => 'XI',
            'country_of_origin' => 'OTHER',
            'other_country_of_origin' => 'AR',
            'planned_processing' => answer,
          }
        end

        it 'returns no path for now' do
          expect(
            step.next_step_path,
          ).to eq(
            interstitial_path,
          )
        end
      end
    end
  end

  describe '#previous_step_path' do
    let(:session_attributes) do
      {
        'import_destination' => 'XI',
        'country_of_origin' => 'GB',
        'trader_scheme' => 'yes',
      }
    end

    context 'when on GB to NI route' do
      it 'returns country_of_origin_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          final_use_path,
        )
      end
    end
  end
end
