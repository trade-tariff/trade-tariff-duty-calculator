RSpec.describe UnitAnswerService, :user_session do
  subject(:result) { described_class.new(unit, applicable_units).call }

  let(:applicable_units) do
    {
      'DTN' => { # Coerced unit
        'measurement_unit_code' => 'DTN',
        'measurement_unit_qualifier_code' => nil,
        'coerced_measurement_unit_code' => 'KGM',
      },
      'DTNR' => { # Coerced duplicate
        'measurement_unit_code' => 'DTN',
        'measurement_unit_qualifier_code' => 'R',
        'coerced_measurement_unit_code' => 'KGM',
      },
      'KGM' => { # Non coerced root unit
        'measurement_unit_code' => 'KGM',
        'measurement_unit_qualifier_code' => nil,
        'coerced_measurement_unit_code' => nil,
      },
    }
  end

  describe '#call' do
    context 'when the unit has a coerced measurement unit code and the unit answer is on the current unit' do
      let(:unit) do
        {
          'measurement_unit_code' => 'DTN',
          'measurement_unit_qualifier_code' => nil,
          'coerced_measurement_unit_code' => 'KGM',
        }
      end

      let(:user_session) do
        build(
          :user_session,
          measure_amount: { 'dtn' => 100 }, # User answer key matches our current unit
        )
      end

      it { is_expected.to eq(100) }
    end

    context 'when the unit has a coerced measurement unit code and the unit answer is on a different unit' do
      let(:unit) do
        {
          'measurement_unit_code' => 'DTN',
          'measurement_unit_qualifier_code' => nil,
          'coerced_measurement_unit_code' => 'KGM',
        }
      end

      let(:user_session) do
        build(
          :user_session,
          measure_amount: { 'dtnr' => 101 }, # User answer key matches dtn not dtnr but has shared coerced unit code
        )
      end

      it { is_expected.to eq(101) }
    end

    context 'when the unit has a coerced measurement unit code and the unit answer is on a different unit that is not coerced' do
      let(:unit) do
        {
          'measurement_unit_code' => 'DTN',
          'measurement_unit_qualifier_code' => nil,
          'coerced_measurement_unit_code' => 'KGM',
        }
      end

      let(:user_session) do
        build(
          :user_session,
          measure_amount: { 'kgm' => 102 }, # User answer key matches the coerced unit
        )
      end

      it { is_expected.to eq(102) }
    end

    context 'when the unit has a coerced measurement unit code and there is no unit answer' do
      let(:unit) do
        {
          'measurement_unit_code' => 'DTN',
          'measurement_unit_qualifier_code' => nil,
          'coerced_measurement_unit_code' => 'KGM',
        }
      end

      let(:user_session) do
        build(
          :user_session,
          measure_amount: {}, # User answer missing
        )
      end

      it { is_expected.to be_nil }
    end

    context 'when the unit is not coerced and there is a unit answer' do
      let(:unit) do
        {
          'measurement_unit_code' => 'KGM',
          'measurement_unit_qualifier_code' => nil,
          'coerced_measurement_unit_code' => nil,
        }
      end

      let(:user_session) do
        build(
          :user_session,
          measure_amount: { 'kgm' => 103 },
        )
      end

      it { is_expected.to eq(103) }
    end

    context 'when the unit is not coerced and there is no unit answer' do
      let(:unit) do
        {
          'measurement_unit_code' => 'KGM',
          'measurement_unit_qualifier_code' => nil,
          'coerced_measurement_unit_code' => nil,
        }
      end

      let(:user_session) do
        build(
          :user_session,
          measure_amount: {},
        )
      end

      it { is_expected.to be_nil }
    end
  end
end
