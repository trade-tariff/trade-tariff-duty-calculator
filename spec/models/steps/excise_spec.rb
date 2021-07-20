RSpec.describe Steps::Excise do
  subject(:step) do
    build(
      :excise,
      user_session: user_session,
    )
  end

  let(:user_session) { build(:user_session, :with_commodity_information) }
  let(:filtered_commodity) { instance_double(Api::Commodity) }
  let(:applicable_vat_options) { {} }

  let(:additional_codes) do
    {
      '306' => {
        'measure_type_description' => 'Excises',
        'heading' => nil,
        'additional_codes' => [
          {
            'code' => 'X520',
            'overlay' => 'EXCISE - FULL, 520, UNREBATED LIGHT OIL, OTHER',
            'hint' => '',
            'measure_sid' => -485_461,
          },
          {
            'code' => 'X522',
            'overlay' => 'EXCISE - FULL, 522, REBATED LIGHT OIL, UNLEADED FUEL',
            'hint' => '',
            'measure_sid' => -485_453,
          },
          {
            'code' => 'X541',
            'overlay' => 'EXCISE - FULL, 541, UNREBATED HEAVY OIL',
            'hint' => '',
            'measure_sid' => -485_455,
          },
          {
            'code' => 'X542',
            'overlay' => 'EXCISE - FULL, 542, KEROSENE AS OFF-ROAD MOTOR VEHICLE FUEL',
            'hint' => '',
            'measure_sid' => -485_456,
          },
          {
            'code' => 'X551',
            'overlay' => 'EXCISE - FULL, 551, REBATED HEAVY OIL, KEROSENE',
            'hint' => '',
            'measure_sid' => -485_457,
          },
          {
            'code' => 'X556',
            'overlay' => 'EXCISE - FULL, 556, REBATED HEAVY OIL, GAS OIL',
            'hint' => '',
            'measure_sid' => -485_458,
          },
          {
            'code' => 'X561',
            'overlay' => 'EXCISE - FULL, 561, REBATED HEAVY OIL, FUEL OIL',
            'hint' => '',
            'measure_sid' => -485_459,
          },
          {
            'code' => 'X570',
            'overlay' => 'EXCISE - FULL, 570, REBATED HEAVY OIL, OTHER',
            'hint' => '',
            'measure_sid' => -485_460,
          },
        ],
      },
    }
  end

  before do
    allow(Api::Commodity).to receive(:build).and_return(filtered_commodity)
    allow(filtered_commodity).to receive(:applicable_additional_codes).and_return(additional_codes)
    allow(filtered_commodity).to receive(:applicable_vat_options).and_return(applicable_vat_options)
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it { expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(%w[]) }
  end

  describe '#validations' do
    context 'when measure_type_id is missing' do
      subject(:step) do
        build(
          :excise,
          user_session: user_session,
          measure_type_id: nil,
        )
      end

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:measure_type_id].to_a).to eq(
          ['Enter a valid measure type id'],
        )
      end
    end

    context 'when the additional_code_uk is not present' do
      subject(:step) do
        build(
          :excise,
          user_session: user_session,
          additional_code_uk: nil,
        )
      end

      let(:user_session) { build(:user_session, :with_commodity_information, :deltas_applicable) }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:additional_code_uk].to_a).to eq(
          ['Specify a valid additional code'],
        )
      end
    end

    context 'when the additional_code_xi is not present' do
      subject(:step) do
        build(
          :excise,
          user_session: user_session,
          additional_code_xi: nil,
        )
      end

      let(:user_session) { build(:user_session, :with_commodity_information, :deltas_applicable) }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:additional_code_xi].to_a).to eq(
          ['Specify a valid additional code'],
        )
      end
    end
  end

  describe '#save' do
    it 'saves the additional codes for uk on to the session' do
      expect { step.save }.to change(user_session, :excise_additional_code_uk).from({}).to('306' => 'X444')
    end

    it 'saves the additional codes for xi on to the session' do
      expect { step.save }.to change(user_session, :excise_additional_code_xi).from({}).to('306' => 'X111')
    end
  end

  describe '#measure_type_description' do
    it 'returns the correct measure type description' do
      expect(step.measure_type_description_for(source: 'uk')).to eq('excises')
    end
  end

  describe '#options_for_select' do
    let(:expected_options) do
      [
        OpenStruct.new(
          id: 'X520',
          name: 'X520 - EXCISE - FULL, 520, UNREBATED LIGHT OIL, OTHER',
        ),
        OpenStruct.new(
          id: 'X522',
          name: 'X522 - EXCISE - FULL, 522, REBATED LIGHT OIL, UNLEADED FUEL',
        ),
        OpenStruct.new(
          id: 'X541',
          name: 'X541 - EXCISE - FULL, 541, UNREBATED HEAVY OIL',
        ),
        OpenStruct.new(
          id: 'X542',
          name: 'X542 - EXCISE - FULL, 542, KEROSENE AS OFF-ROAD MOTOR VEHICLE FUEL',
        ),
        OpenStruct.new(
          id: 'X551',
          name: 'X551 - EXCISE - FULL, 551, REBATED HEAVY OIL, KEROSENE',
        ),
        OpenStruct.new(
          id: 'X556',
          name: 'X556 - EXCISE - FULL, 556, REBATED HEAVY OIL, GAS OIL',
        ),
        OpenStruct.new(
          id: 'X561',
          name: 'X561 - EXCISE - FULL, 561, REBATED HEAVY OIL, FUEL OIL',
        ),
        OpenStruct.new(
          id: 'X570',
          name: 'X570 - EXCISE - FULL, 570, REBATED HEAVY OIL, OTHER',
        ),
      ]
    end

    it 'returns the correct additonal code options for the given measure' do
      expect(step.options_for_select_for(source: 'uk')).to eq(expected_options)
    end
  end

  describe '#additional_code_uk' do
    context 'when there are attributes being passed in' do
      it 'returns the additional code attribute value on the active model' do
        expect(step.additional_code_uk).to eq('X444')
      end
    end

    context 'when there is no additional codes being passed in, but the value is on the session' do
      subject(:step) do
        build(
          :excise,
          user_session: user_session,
          additional_code_uk: nil,
        )
      end

      let(:user_session) do
        build(
          :user_session,
          :with_excise_additional_codes,
          :with_commodity_information,
        )
      end

      it { is_expected.to be_valid }

      it 'returns the value from the session that corresponds to measure type 306' do
        expect(step.additional_code_uk).to eq('X444')
      end
    end
  end

  describe '#additional_code_xi' do
    context 'when there are attributes being passed in' do
      it 'returns the additional code attribute value on the active model' do
        expect(step.additional_code_xi).to eq('X111')
      end
    end

    context 'when there is no additional code being passed in, but the value is on the session' do
      subject(:step) do
        build(
          :excise,
          user_session: user_session,
          additional_code_xi: nil,
        )
      end

      let(:user_session) do
        build(
          :user_session,
          :with_excise_additional_codes,
          :with_commodity_information,
        )
      end

      it { is_expected.to be_valid }

      it 'returns the value from the session that corresponds to measure type 306' do
        expect(step.additional_code_xi).to eq('X111')
      end
    end
  end

  # xdescribe '#previous_step_path' do
  # end

  # xdescribe '#next_step_path' do
  # end
end
