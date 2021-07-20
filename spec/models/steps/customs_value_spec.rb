RSpec.describe Steps::CustomsValue, :step, :user_session do
  subject(:step) do
    build(
      :customs_value,
      user_session: user_session,
      monetary_value: monetary_value,
      insurance_cost: insurance_cost,
      shipping_cost: shipping_cost,
    )
  end

  let(:user_session) { build(:user_session, import_date: '2022-01-01') }
  let(:monetary_value) { '12_500' }
  let(:insurance_cost) { '1_200' }
  let(:shipping_cost) { '340' }

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[additional_code],
      )
    end
  end

  describe '#validations' do
    context 'when monetary_value is blank' do
      let(:monetary_value) { '' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a valid monetary value', 'Enter a numeric monetary value'],
        )
      end
    end

    context 'when monetary_value is 0' do
      let(:monetary_value) { '0' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a monetary value greater than zero'],
        )
      end
    end

    context 'when monetary_value is a negative number' do
      let(:monetary_value) { '-999' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a monetary value greater than zero'],
        )
      end
    end

    context 'when insurance_cost is blank' do
      let(:monetary_value) { '1234' }
      let(:insurance_cost) { '' }

      it 'is a valid object' do
        expect(step).to be_valid
      end
    end

    context 'when insurance_cost is a negative number' do
      let(:insurance_cost) { '-999' }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:insurance_cost].to_a).to eq(
          ['Enter a insurance cost value greater than or equal to zero'],
        )
      end
    end

    context 'when insurance_cost is not numeric' do
      let(:monetary_value) { '1234' }
      let(:insurance_cost) { 'fff' }

      it 'is a not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:insurance_cost].to_a).to eq(
          ['Enter a numeric insurance cost or leave the field blank'],
        )
      end
    end

    context 'when shipping_cost is blank' do
      let(:monetary_value) { '1234' }
      let(:shipping_cost) { '' }

      it 'is a valid object' do
        expect(step).to be_valid
      end
    end

    context 'when shipping_cost is not numeric' do
      let(:monetary_value) { '1234' }
      let(:shipping_cost) { 'fff' }

      it 'is a not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:shipping_cost].to_a).to eq(
          ['Enter a numeric shipping cost or leave the field blank'],
        )
      end
    end

    context 'when shipping_cost is a negative number' do
      let(:monetary_value) { '1234' }
      let(:shipping_cost) { '-999' }

      it 'is a not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:shipping_cost].to_a).to eq(
          ['Enter a shipping cost value greater than or equal to zero'],
        )
      end
    end
  end

  describe '#save' do
    it 'saves the monetary_value on to the session' do
      step.save

      expect(user_session.monetary_value).to eq '12_500'
    end

    it 'saves the insurance_cost on to the session' do
      step.save

      expect(user_session.insurance_cost).to eq '1_200'
    end

    it 'saves the shipping_cost on to the session' do
      step.save

      expect(user_session.shipping_cost).to eq '340'
    end
  end

  describe '#previous_step_path' do
    context 'when on GB to NI route' do
      before do
        allow(user_session).to receive(:gb_to_ni_route?).and_return(true)
      end

      context 'when there is a trade defence' do
        let(:user_session) { build(:user_session, trade_defence: true) }

        it 'returns interstitial_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            interstitial_path,
          )
        end
      end

      context 'when there is no trade defence, and the certificate of origin answer is NO' do
        let(:session) do
          {
            'certificate_of_origin' => 'no',
          }
        end

        it 'returns certificate_of_origin_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            certificate_of_origin_path,
          )
        end
      end
    end

    context 'when on RoW to GB route' do
      before do
        allow(user_session).to receive(:row_to_gb_route?).and_return(true)
      end

      it 'returns country_of_origin_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          country_of_origin_path,
        )
      end
    end

    context 'when on RoW to NI route' do
      before do
        allow(user_session).to receive(:row_to_ni_route?).and_return(true)
      end

      context 'when there is a zero mfn duty' do
        it 'returns country_of_origin_path' do
          allow(user_session).to receive(:zero_mfn_duty).and_return(true)

          expect(
            step.previous_step_path,
          ).to eq(
            country_of_origin_path,
          )
        end
      end

      context 'when the goods are not for commercial_purposes' do
        let(:user_session) { build(:user_session, planned_processing: 'annual_turnover') }

        it 'returns planned_processing_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            planned_processing_path,
          )
        end
      end

      context 'when the goods are not for final use' do
        let(:user_session) { build(:user_session, final_use: 'no') }

        it 'returns final_use_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            final_use_path,
          )
        end
      end

      context 'when trader is not part of a trader scheme' do
        let(:user_session) { build(:user_session, trader_scheme: 'no') }

        it 'returns trader_scheme_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            trader_scheme_path,
          )
        end
      end
    end
  end

  describe '#next_step_path' do
    let(:applicable_measure_units) do
      {
        'DTN' => {
          'measurement_unit_code' => 'DTN',
          'measurement_unit_qualifier_code' => '',
          'abbreviation' => '100 kg',
          'unit_question' => 'What is the weight of the goods you will be importing?',
          'unit_hint' => 'Enter the value in decitonnes (100kg)',
          'unit' => 'x 100 kg',
        },
      }
    end

    let(:filtered_commodity) { instance_double(Api::Commodity) }

    before do
      allow(Api::Commodity).to receive(:build).and_return(filtered_commodity)
      allow(filtered_commodity).to receive(:applicable_measure_units).and_return(applicable_measure_units)
    end

    context 'when there are applicable measures' do
      it 'returns measure_amount_path' do
        expect(
          step.next_step_path,
        ).to eq(
          measure_amount_path,
        )
      end
    end

    context 'when there are no applicable measures' do
      let(:applicable_measure_units) { {} }
      let(:session) do
        {
          'answers' => {
            'import_date' => '2022-01-01',
            Steps::MeasureAmount.id => { foo: :bar },
          },
        }
      end

      let(:first_measure_type_id) { '105' }
      let(:applicable_additional_codes) { {} }
      let(:applicable_vat_options) { {} }

      before do
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
            additional_codes_path(first_measure_type_id),
          )
        end
      end

      context 'when there are excise additional codes' do
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

        it 'returns excise_path' do
          expect(step.next_step_path).to eq(excise_path('306'))
        end
      end

      context 'when there is just one VAT option' do
        let(:applicable_vat_options) do
          {
            'VATZ' => 'flibble',
          }
        end

        it 'returns confirmation_path' do
          expect(
            step.next_step_path,
          ).to eq(
            confirm_path,
          )
        end
      end

      context 'when there are multiple VAT options' do
        let(:applicable_vat_options) do
          {
            'VATZ' => 'flibble',
            'VAT' => 'foo',
          }
        end

        it 'returns confirmation_path' do
          expect(
            step.next_step_path,
          ).to eq(
            vat_path,
          )
        end
      end

      it 'returns confirmation_path' do
        expect(
          step.next_step_path,
        ).to eq(
          confirm_path,
        )
      end

      it 'removes any leftover value for measure amounts from the session' do
        step.next_step_path

        expect(user_session.measure_amount).to be_empty
      end
    end
  end
end
