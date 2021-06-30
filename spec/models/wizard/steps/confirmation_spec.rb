RSpec.describe Wizard::Steps::Confirmation do
  subject(:step) { build(:confirmation, user_session: user_session) }

  let(:user_session) { build(:user_session, :with_commodity_information) }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(%w[])
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    it 'return duty path' do
      expect(
        step.next_step_path,
      ).to eq(
        duty_path,
      )
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    context 'when there are more than one applicable vat options' do
      let(:user_session) { build(:user_session, :with_commodity_information) }

      it 'returns vat_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          vat_path,
        )
      end
    end

    context 'when there us just one  applicable vat option available' do
      let(:user_session) { build(:user_session, :with_commodity_information, commodity_code: '0102291010') }

      it 'returns vat_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          customs_value_path,
        )
      end
    end

    context 'when there are additional codes on the session' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_additional_codes,
          commodity_code: '0103921100',
        )
      end

      it 'returns additional_codes path with the last measure type id as id' do
        expect(
          step.previous_step_path,
        ).to eq(
          additional_codes_path('103'),
        )
      end
    end

    context 'when there are measure amounts on the session' do
      let(:measure_amount) do
        {
          'dtn' => 1,
        }
      end

      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          commodity_code: '0103921100',
        )
      end

      before do
        allow(user_session).to receive(:measure_amount).and_return(measure_amount)
      end

      it 'returns measure_amount_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          measure_amount_path,
        )
      end
    end

    context 'when there are no measure amounts on the session' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          commodity_code: '0103921100',
        )
      end

      before do
        allow(user_session).to receive(:measure_amount).and_return({})
      end

      it 'returns measure_amount_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          customs_value_path,
        )
      end
    end
  end
end
