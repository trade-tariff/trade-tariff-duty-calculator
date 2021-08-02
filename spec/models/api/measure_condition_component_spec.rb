RSpec.describe Api::MeasureConditionComponent do
  subject(:component) do
    described_class.new(
      'duty_expression_id' => '01',
      'duty_amount' => 10.0,
      'monetary_unit_code' => nil,
      'monetary_unit_abbreviation' => nil,
      'measurement_unit_code' => nil,
      'duty_expression_description' => '% or amount',
      'duty_expression_abbreviation' => '%',
      'measurement_unit_qualifier_code' => nil,
    )
  end

  it_behaves_like 'a resource that has attributes', duty_expression_id: '01',
                                                    duty_amount: 0.0,
                                                    monetary_unit_code: nil,
                                                    monetary_unit_abbreviation: nil,
                                                    measurement_unit_code: nil,
                                                    duty_expression_description: '% or amount',
                                                    duty_expression_abbreviation: '%',
                                                    measurement_unit_qualifier_code: nil

  describe '#ad_valorem?' do
    context 'when it is ad_valorem' do
      it 'returns true' do
        expect(component).to be_ad_valorem
      end
    end

    context 'when it is not ad_valorem' do
      subject(:component) do
        described_class.new(
          'duty_expression_id' => '01',
          'duty_amount' => 10.0,
          'monetary_unit_code' => 'GBP',
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => 'DTN',
          'duty_expression_description' => '% or amount',
          'duty_expression_abbreviation' => '%',
          'measurement_unit_qualifier_code' => nil,
        )
      end

      it 'returns false' do
        expect(component).not_to be_ad_valorem
      end
    end
  end

  describe '#specific_duty?' do
    subject(:component) do
      described_class.new(
        'duty_expression_id' => '01',
        'duty_amount' => 10.0,
        'monetary_unit_code' => 'GBP',
        'monetary_unit_abbreviation' => nil,
        'measurement_unit_code' => nil,
        'duty_expression_description' => '% or amount',
        'duty_expression_abbreviation' => '%',
        'measurement_unit_qualifier_code' => nil,
      )
    end

    context 'when measurement_unit_code is present' do
      subject(:component) do
        described_class.new(
          'duty_expression_id' => '01',
          'duty_amount' => 10.0,
          'monetary_unit_code' => nil,
          'monetary_unit_abbreviation' => nil,
          'measurement_unit_code' => 'DTN',
          'duty_expression_description' => '% or amount',
          'duty_expression_abbreviation' => '%',
          'measurement_unit_qualifier_code' => nil,
        )
      end

      it 'returns true' do
        expect(component).to be_specific_duty
      end
    end
  end

  describe '#no_specific_duty?' do
    subject(:component) do
      described_class.new(
        'duty_expression_id' => '01',
        'duty_amount' => 10.0,
        'monetary_unit_code' => nil,
        'monetary_unit_abbreviation' => nil,
        'measurement_unit_code' => nil,
        'duty_expression_description' => '% or amount',
        'duty_expression_abbreviation' => '%',
        'measurement_unit_qualifier_code' => nil,
      )
    end

    context 'when not a specific duty' do
      it 'returns true' do
        expect(component).to be_no_specific_duty
      end
    end
  end

  describe '#conjunction_operator?' do
    subject(:component) do
      described_class.new(
        'duty_expression_id' => '01',
        'duty_amount' => 10.0,
        'monetary_unit_code' => nil,
        'monetary_unit_abbreviation' => nil,
        'measurement_unit_code' => nil,
        'duty_expression_description' => '% or amount',
        'duty_expression_abbreviation' => duty_expression_abbreviation,
        'measurement_unit_qualifier_code' => nil,
      )
    end

    let(:duty_expression_abbreviation) { '%' }

    context 'when it is a conjunction operator' do
      let(:duty_expression_abbreviation) { 'MAX' }

      it 'returns true' do
        expect(component).to be_conjunction_operator
      end
    end

    context 'when it is not a conjunction operator' do
      it 'returns false' do
        expect(component).not_to be_conjunction_operator
      end
    end
  end

  describe '#operator' do
    it 'returns %' do
      expect(component.operator).to eq '%'
    end
  end

  describe '#eql?' do
    subject(:component) do
      described_class.new(
        'duty_expression_id' => '01',
        'duty_amount' => 10.0,
      )
    end

    let(:other_component) do
      described_class.new(
        'duty_expression_id' => '01',
        'duty_amount' => other_component_duty_amount,
      )
    end

    context 'when the components are the same' do
      let(:other_component_duty_amount) { 10.0 }

      it { expect(component).to eql(other_component) }
    end

    context 'when the components are different' do
      let(:other_component_duty_amount) { 12.0 }

      it { expect(component).not_to eql(other_component) }
    end
  end
end
