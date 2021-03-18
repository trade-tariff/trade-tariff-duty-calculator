require 'rails_helper'

RSpec.describe Wizard::Steps::MeasureAmount do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }
  let(:attributes) do
    ActionController::Parameters.new(
      'measure_amount' => measure_amount,
      'applicable_measure_units' => {
        'HLT' => {
          'measurement_unit_code' => 'HLT',
          'measurement_unit_qualifier_code' => '',
          'abbreviation' => 'hl',
          'unit_question' => 'What is the volume of the goods that you will be importing?',
          'unit_hint' => 'Enter the value in hectolitres (100 litres)',
          'unit' => 'x 100 litres',
          'measure_sids' => [
            20_002_280,
          ],
        },
        'DTN' => {
          'measurement_unit_code' => 'DTN',
          'measurement_unit_qualifier_code' => '',
          'abbreviation' => '100 kg',
          'unit_question' => 'What is the weight of the goods you will be importing?',
          'unit_hint' => 'Enter the value in decitonnes (100kg)',
          'unit' => 'x 100 kg',
          'measure_sids' => [
            20_005_920,
            20_056_507,
            20_073_335,
            20_076_779,
            20_090_066,
            20_105_690,
            20_078_066,
            20_102_998,
            20_108_866,
            20_085_014,
          ],
        },
      },
    ).permit!
  end

  let(:measure_amount) { { 'dtn' => 500.42, 'hlt' => 204.64 } }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to be_empty
    end
  end

  describe '#validations' do
    context 'when all answers are present, positive floats' do
      let(:measure_amount) { { 'dtn' => 500.42, 'hlt' => 204.64 } }

      it 'is a valid object' do
        expect(step.valid?).to be true
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages).to be_empty
      end
    end

    context 'when one of the answers is blank' do
      let(:measure_amount) { { 'dtn' => 500.42 } }

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:hlt]).to eq(
          [
            'Enter a valid import quantity. Enter the value in hectolitres (100 litres)',
            'Enter a numeric import quantity. Enter the value in hectolitres (100 litres)',
          ],
        )
      end
    end

    context 'when one of the answers is negative' do
      let(:measure_amount) { { 'dtn' => 500.42, 'hlt' => -1.5 } }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:hlt]).to eq(
          [
            'Enter an import quantity value greater than zero. Enter the value in hectolitres (100 litres)',
          ],
        )
      end
    end

    context 'when one of the answers is not a numeric' do
      let(:measure_amount) { { 'dtn' => 500.42, 'hlt' => 'foo' } }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error message' do
        step.valid?

        expect(step.errors.messages[:hlt]).to eq(
          [
            'Enter a numeric import quantity. Enter the value in hectolitres (100 litres)',
          ],
        )
      end
    end
  end

  describe '#save' do
    it 'saves the measure_amount to the session' do
      step.save

      expect(user_session.measure_amount).to eq(measure_amount)
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'returns customs_value_path' do
      expect(
        step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
      ).to eq(
        customs_value_path(service_choice: service_choice, commodity_code: commodity_code),
      )
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'returns confirm_path' do
      expect(
        step.next_step_path(service_choice: service_choice, commodity_code: commodity_code),
      ).to eq(
        confirm_path(service_choice: service_choice, commodity_code: commodity_code),
      )
    end
  end
end
