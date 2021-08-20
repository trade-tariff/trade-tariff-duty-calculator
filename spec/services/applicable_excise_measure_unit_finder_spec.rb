RSpec.describe ApplicableExciseMeasureUnitFinder, :user_session do
  subject(:service) { described_class.new(commodity) }

  let(:commodity) { Api::Commodity.build(service, '0103921100') }
  let(:user_session) { build(:user_session) }

  describe '#call' do
    context 'when there are excise units' do
      let(:service) { 'uk' } # UK commodity has excise measures

      let(:expected_units) do
        {
          'RET' => {
            'measurement_unit_code' => 'RET',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => 'GBP',
            'unit_question' => 'What is the retail price of the goods you will be importing?',
            'unit_hint' => 'Enter the value in pounds',
            'unit' => '£',
            'component_ids' => ['-1010806389-01'],
            'condition_component_ids' => [],
          },
          'MIL' => {
            'measurement_unit_code' => 'MIL',
            'measurement_unit_qualifier_code' => '',
            'abbreviation' => '1,000 p/st',
            'unit_question' => 'How many items will you be importing?',
            'unit_hint' => 'Enter the value in thousands of items',
            'unit' => 'x 1,000 items',
            'component_ids' => [
              '-1010806389-04',
              '-1010806389-15',
            ],
            'condition_component_ids' => [],
          },
        }
      end

      it { expect(commodity.applicable_excise_measure_units).to eq(expected_units) }
    end

    context 'when there are no excise units' do
      let(:service) { 'xi' } # XI doesn't have excise measures

      let(:expected_units) { {} }

      it { expect(commodity.applicable_excise_measure_units).to eq(expected_units) }
    end
  end
end
