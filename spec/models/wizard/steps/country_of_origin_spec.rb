RSpec.describe Wizard::Steps::CountryOfOrigin do
  subject(:step) { described_class.new(user_session, attributes, opts) }

  let(:user_session) { build(:user_session, session_attributes) }
  let(:session_attributes) { {} }
  let(:opts) { {} }

  let(:attributes) do
    ActionController::Parameters.new(
      country_of_origin: '',
    ).permit(:country_of_origin)
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[
          trader_scheme
          final_use
          certificate_of_origin
          planned_processing
        ],
      )
    end
  end

  describe '#validations' do
    context 'when country_of_origin is blank' do
      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:country_of_origin]).to eq(['Enter a valid origin for this import'])
      end
    end

    context 'when country_of_origin is present' do
      let(:attributes) do
        ActionController::Parameters.new(
          country_of_origin: '1',
        ).permit(:country_of_origin)
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages[:country_of_origin]).to be_empty
      end
    end
  end

  describe '#save' do
    let(:attributes) do
      ActionController::Parameters.new(
        country_of_origin: 'GB',
      ).permit(:country_of_origin)
    end

    before do
      step.save
    end

    it 'saves the country_of_origin to the session' do
      expect(user_session.country_of_origin).to eq 'GB'
    end

    context 'when trade_defence and zero_mfn_duty are passed in as options' do
      let(:opts) do
        {
          trade_defence: true,
          zero_mfn_duty: false,
        }
      end

      it 'stores trade_defence on the session' do
        expect(user_session.trade_defence).to eq(true)
      end

      it 'stores zero_mfn_duty on the session' do
        expect(user_session.zero_mfn_duty).to eq(false)
      end
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    it 'returns import_destination_path' do
      expect(
        step.previous_step_path,
      ).to eq(
        import_destination_path,
      )
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    context 'when on NI to GB route' do
      let(:session_attributes) do
        {
          'import_destination' => 'UK',
          'country_of_origin' => 'XI',
        }
      end

      it 'returns duty_path' do
        expect(
          step.next_step_path,
        ).to eq(
          duty_path,
        )
      end
    end

    context 'when on GB to NI route and there is a trade defence in place' do
      let(:opts) do
        {
          trade_defence: true,
        }
      end

      let(:session_attributes) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
        }
      end

      it 'returns the trade_remedies_path' do
        expect(
          step.next_step_path,
        ).to eq(
          trade_remedies_path,
        )
      end
    end

    context 'when on GB to NI route and there is no trade defence in place, but a zero_mfn_duty' do
      let(:opts) do
        {
          trade_defence: false,
          zero_mfn_duty: true,
        }
      end

      let(:session_attributes) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
        }
      end

      it 'returns the duty_path' do
        expect(
          step.next_step_path,
        ).to eq(
          duty_path,
        )
      end
    end

    context 'when on GB to NI route and there is no trade defence in place, nor a zero_mfn_duty' do
      let(:opts) do
        {
          trade_defence: false,
          zero_mfn_duty: false,
        }
      end

      let(:session_attributes) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'GB',
        }
      end

      it 'returns the trader_scheme_path' do
        expect(
          step.next_step_path,
        ).to eq(
          trader_scheme_path,
        )
      end
    end

    context 'when on RoW to GB route' do
      let(:session_attributes) do
        {
          'import_destination' => 'UK',
          'country_of_origin' => 'RO',
        }
      end

      it 'returns the customs_value_path' do
        expect(
          step.next_step_path,
        ).to eq(
          customs_value_path,
        )
      end
    end
  end
end
