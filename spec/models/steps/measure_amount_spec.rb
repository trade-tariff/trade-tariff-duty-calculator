RSpec.describe Steps::MeasureAmount, :step, :user_session do
  subject(:step) do
    build(
      :measure_amount,
      user_session: user_session,
      measure_amount: measure_amount,
    )
  end

  let(:user_session) { build(:user_session, session_attributes) }
  let(:measure_amount) { { 'dtn' => 500.42, 'hlt' => 204.64 } }

  let(:session_attributes) do
    {
      'commodity_code' => '0702000007',
      'commodity_source' => 'uk',
      'referred_service' => 'uk',
      'import_date' => '2022-01-01',
    }
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(%w[additional_code document_code])
    end
  end

  describe '#validations' do
    context 'when all answers are present, positive floats' do
      let(:measure_amount) { { 'dtn' => 500.42, 'hlt' => 204.64 } }

      it 'is a valid object' do
        expect(step).to be_valid
      end

      it 'has no validation errors' do
        step.valid?

        expect(step.errors.messages).to be_empty
      end
    end

    context 'when one of the answers is blank' do
      let(:measure_amount) { { 'dtn' => 500.42 } }

      it 'is not a valid object' do
        expect(step).not_to be_valid
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
    it 'returns customs_value_path' do
      expect(step.previous_step_path).to eq(customs_value_path)
    end
  end

  describe '#next_step_path' do
    let(:applicable_additional_codes) { {} }
    let(:applicable_vat_options) { {} }

    let(:commodity_source) { :uk }
    let(:commodity_code) { '7202118000' }

    let(:filtered_commodity) do
      Api::Commodity.build(
        commodity_source,
        commodity_code,
      )
    end

    before do
      allow(Api::Commodity).to receive(:build).and_return(filtered_commodity)
      allow(filtered_commodity).to receive(:applicable_additional_codes).and_return(applicable_additional_codes)
      allow(filtered_commodity).to receive(:applicable_vat_options).and_return(applicable_vat_options)
    end

    context 'when there are applicable additional codes available' do
      let(:applicable_additional_codes) do
        {
          '105' => {
            'additional_codes' => [
              { 'code' => '2600' },
              { 'code' => '2601' },
            ],
          },

          '552' => {
            'additional_codes' => [
              { 'code' => 'B999' },
              { 'code' => 'B349' },
            ],
          },
        }
      end

      it 'redirects to the additional_codes_path of the first measure type id' do
        expect(
          step.next_step_path,
        ).to eq(
          additional_codes_path('105'),
        )
      end
    end

    context 'when there are applicable excise additional codes available' do
      let(:applicable_additional_codes) do
        {
          '306' => {
            'additional_codes' => [
              { 'code' => 'X411' },
              { 'code' => 'X444' },
            ],
          },
        }
      end

      it 'redirects to the additional_codes_path of the first measure type id' do
        expect(step.next_step_path).to eq(excise_path('306'))
      end
    end

    context 'when there are less than 2 applicable vat options' do
      let(:applicable_vat_options) do
        {
          'VATZ' => 'flibble',
        }
      end

      it 'returns confirm_path' do
        expect(step.next_step_path).to eq(confirm_path)
      end
    end

    context 'when there are more than 1 applicable vat options' do
      let(:applicable_vat_options) do
        {
          'VATZ' => 'flibble',
          'VATR' => 'foobar',
        }
      end

      it 'returns vat_path' do
        expect(step.next_step_path).to eq(vat_path)
      end
    end

    it 'returns confirm_path' do
      expect(
        step.next_step_path,
      ).to eq(
        confirm_path,
      )
    end
  end
end
