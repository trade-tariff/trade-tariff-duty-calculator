RSpec.describe Wizard::Steps::CustomsValue do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:user_session) { build(:user_session, import_date: '2022-01-01') }

  let(:attributes) do
    ActionController::Parameters.new(
      monetary_value: '12_500',
      insurance_cost: '1_200',
      shipping_cost: '340',
    ).permit(
      :monetary_value,
      :insurance_cost,
      :shipping_cost,
    )
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[additional_code],
      )
    end
  end

  describe '#validations' do
    context 'when monetary_value is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '',
        ).permit(:monetary_value)
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a valid monetary value', 'Enter a numeric monetary value'],
        )
      end
    end

    context 'when monetary_value is 0' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '0',
        ).permit(:monetary_value)
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a monetary value greater than zero'],
        )
      end
    end

    context 'when monetary_value is a negative number' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '-999',
        ).permit(:monetary_value)
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a monetary value greater than zero'],
        )
      end
    end

    context 'when insurance_cost is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: '',
        ).permit(
          :monetary_value,
          :insurance_cost,
        )
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end
    end

    context 'when insurance_cost is a negative number' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: '-999',
        ).permit(
          :monetary_value,
          :insurance_cost,
        )
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:insurance_cost].to_a).to eq(
          ['Enter a insurance cost value greater than or equal to zero'],
        )
      end
    end

    context 'when insurance_cost is not numeric' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: 'sdadsa',
        ).permit(
          :monetary_value,
          :insurance_cost,
        )
      end

      it 'is a not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:insurance_cost].to_a).to eq(
          ['Enter a numeric insurance cost or leave the field blank'],
        )
      end
    end

    context 'when shipping_cost is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: '1234',
          shipping_cost: '',
        ).permit(
          :monetary_value,
          :insurance_cost,
          :shipping_cost,
        )
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end
    end

    context 'when shipping_cost is not numeric' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: '1234',
          shipping_cost: 'dwsda',
        ).permit(
          :monetary_value,
          :insurance_cost,
          :shipping_cost,
        )
      end

      it 'is a not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:shipping_cost].to_a).to eq(
          ['Enter a numeric shipping cost or leave the field blank'],
        )
      end
    end

    context 'when shipping_cost is a negative number' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: '1234',
          shipping_cost: '-999',
        ).permit(
          :monetary_value,
          :insurance_cost,
          :shipping_cost,
        )
      end

      it 'is a not a valid object' do
        expect(step.valid?).to be false
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
    include Rails.application.routes.url_helpers

    context 'when on GB to NI route' do
      before do
        allow(user_session).to receive(:gb_to_ni_route?).and_return(true)
      end

      context 'when there is a trade defence' do
        let(:user_session) { build(:user_session, trade_defence: true) }

        it 'returns trade_remedies_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            trade_remedies_path,
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

      it 'returns certificate_of_origin_path' do
        expect(
          step.previous_step_path,
        ).to eq(
          country_of_origin_path,
        )
      end
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

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
            Wizard::Steps::MeasureAmount.id => { foo: :bar },
          },
        }
      end

      let(:first_measure_type_id) { '105' }
      let(:applicable_additional_codes) { {} }

      before do
        allow(filtered_commodity).to receive(:applicable_additional_codes).and_return(applicable_additional_codes)
      end

      context 'when there are applicable additional codes available' do
        let(:applicable_additional_codes) do
          {
            '105' => {
              'heading' => {
                'overlay' => 'Describe your goods in more detail',
                'hint' => 'To trade this commodity, you need to specify an additional 4 digits, known as an additional code',
              },
              'additional_codes' => [
                {
                  'code' => '2600',
                  'overlay' => 'The product I am importing is COVID-19 critical',
                  'hint' => "Read more about the <a target='_blank' href='https://www.gov.uk/government/news/hmg-suspends-import-tariffs-on-covid-19-products-to-fight-virus'>suspension of tariffs on COVID-19 critical goods [opens in a new browser window]</a>",
                },
                {
                  'code' => '2601',
                  'overlay' => 'The product I am importing is not COVID-19 critical',
                  'hint' => '',
                },
              ],
            },

            '552' => {
              'heading' => {
                'overlay' => 'Describe your goods in more detail',
                'hint' => 'To trade this commodity, you need to specify an additional 4 digits, known as an additional code',
              },
              'additional_codes' => [
                {
                  'code' => 'B999',
                  'overlay' => 'Other',
                  'hint' => '',
                  'type' => 'preference',
                  'measure_sid' => '20511102',
                },
                {
                  'code' => 'B349',
                  'overlay' => 'Hunan Hualian China Industry Co., Ltd; Hunan Hualian Ebillion China Industry Co., Ltd; Hunan Liling Hongguanyao China Industry Co., Ltd; Hunan Hualian Yuxiang China Industry Co., Ltd.',
                  'hint' => '',
                  'type' => 'preference',
                  'measure_sid' => '20511103',
                },
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
