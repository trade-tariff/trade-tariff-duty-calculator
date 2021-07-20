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
            'overlay' => '520 - Light oil: unrebated (unmarked) – other unrebated light oil',
            'hint' => '',
            'measure_sid' => -485_461,
          },
          {
            'code' => 'X522',
            'overlay' => '522 - Light oil: rebated – unleaded petrol',
            'hint' => '',
            'measure_sid' => -485_453,
          },
          {
            'code' => 'X541',
            'overlay' => '541 - Heavy oil: unrebated (unmarked, including Diesel Engine Road Vehicle (DERV) or road fuel extender and unmarked kerosene or unmarked gas oil for which no marking waiver has been granted)',
            'hint' => '',
            'measure_sid' => -485_455,
          },
          {
            'code' => 'X542',
            'overlay' => '542 - Heavy oil: kerosene to be used as motor fuel off road or in an excepted vehicle',
            'hint' => '',
            'measure_sid' => -485_456,
          },
          {
            'code' => 'X551',
            'overlay' => '551 - Heavy oil: kerosene (marked or unmarked under marking waiver, including heavy oil aviation turbine fuel) to be used other than as motor fuel off-road or in an excepted vehicle',
            'hint' => '',
            'measure_sid' => -485_457,
          },
          {
            'code' => 'X556',
            'overlay' => '556 - Heavy oil: gas oil (marked or unmarked under marking waiver)',
            'hint' => '',
            'measure_sid' => -485_458,
          },
          {
            'code' => 'X561',
            'overlay' => '561 - Heavy oil: fuel oil (unmarked)',
            'hint' => '',
            'measure_sid' => -485_459,
          },
          {
            'code' => 'X570',
            'overlay' => '570 - Heavy oil: other (unmarked)',
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

    context 'when the additional_code is not present' do
      subject(:step) do
        build(
          :excise,
          user_session: user_session,
          additional_code: nil,
        )
      end

      let(:user_session) { build(:user_session, :with_commodity_information) }

      it 'is not a valid object' do
        expect(step).not_to be_valid
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:additional_code].to_a).to eq(['Select an excise class'])
      end
    end
  end

  describe '#save' do
    it 'saves the additional codes on to the session' do
      expect { step.save }.to change(user_session, :excise_additional_code).from({}).to('306' => 'X444')
    end
  end

  describe '#measure_type_description' do
    it { expect(step.measure_type_description).to eq('excises') }
  end

  describe '#options_for_radio_buttons' do
    let(:expected_options) do
      [
        OpenStruct.new(
          id: '520',
          name: '520 - Light oil: unrebated (unmarked) – other unrebated light oil',
        ),
        OpenStruct.new(
          id: '522',
          name: '522 - Light oil: rebated – unleaded petrol',
        ),
        OpenStruct.new(
          id: '541',
          name: '541 - Heavy oil: unrebated (unmarked, including Diesel Engine Road Vehicle (DERV) or road fuel extender and unmarked kerosene or unmarked gas oil for which no marking waiver has been granted)',
        ),
        OpenStruct.new(
          id: '542',
          name: '542 - Heavy oil: kerosene to be used as motor fuel off road or in an excepted vehicle',
        ),
        OpenStruct.new(
          id: '551',
          name: '551 - Heavy oil: kerosene (marked or unmarked under marking waiver, including heavy oil aviation turbine fuel) to be used other than as motor fuel off-road or in an excepted vehicle',
        ),
        OpenStruct.new(
          id: '556',
          name: '556 - Heavy oil: gas oil (marked or unmarked under marking waiver)',
        ),
        OpenStruct.new(
          id: '561',
          name: '561 - Heavy oil: fuel oil (unmarked)',
        ),
        OpenStruct.new(
          id: '570',
          name: '570 - Heavy oil: other (unmarked)',
        ),
      ]
    end

    it 'returns the correct additonal code options for the given measure' do
      expect(step.options_for_radio_buttons).to eq(expected_options)
    end
  end

  describe '#additional_code' do
    context 'when there are attributes being passed in' do
      it 'returns the additional code attribute value on the active model' do
        expect(step.additional_code).to eq('X444')
      end
    end

    context 'when there is no additional codes being passed in, but the value is on the session' do
      subject(:step) do
        build(
          :excise,
          user_session: user_session,
          additional_code: nil,
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
        expect(step.additional_code).to eq('X444')
      end
    end
  end

  # xdescribe '#previous_step_path' do
  # end

  # xdescribe '#next_step_path' do
  # end
end
