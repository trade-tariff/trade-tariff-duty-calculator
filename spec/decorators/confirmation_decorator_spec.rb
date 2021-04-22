RSpec.describe ConfirmationDecorator do
  subject(:confirmation_decorator) { described_class.new(confirmation_step, commodity) }

  let(:confirmation_step) { Wizard::Steps::Confirmation.new(user_session) }

  let(:commodity) { double(Uktt::Commodity) }
  let(:commodity_code) { '0702000007' }
  let(:commodity_source) { 'uk' }
  let(:user_session) { build(:user_session, session_attributes) }
  let(:referred_service) { 'uk' }
  let(:session_attributes) do
    {
      'commodity_code' => commodity_code,
      'referred_service' => referred_service,
    }
  end

  before do
    allow(commodity).to receive(:code).and_return(commodity_code)
    allow(Api::Commodity).to receive(:build).with(commodity_source.to_sym, commodity_code).and_return(commodity)
  end

  describe 'ORDERED_STEPS' do
    it 'returns the correct steps' do
      expect(described_class::ORDERED_STEPS).to eq(
        %w[
          import_date
          import_destination
          country_of_origin
          trader_scheme
          final_use
          planned_processing
          certificate_of_origin
          customs_value
          measure_amount
        ],
      )
    end
  end

  describe '#user_answers' do
    let(:session_attributes) do
      {
        'import_date' => '2090-01-01',
        'import_destination' => 'XI',
        'country_of_origin' => 'GB',
        'trader_scheme' => 'yes',
        'final_use' => 'yes',
        'planned_processing' => 'commercial_purposes',
        'certificate_of_origin' => 'no',
        'customs_value' => {
          'insurance_cost' => '10',
          'monetary_value' => '10',
          'shipping_cost' => '10',
        },
        'measure_amount' => {
          'dtn' => '120',
        },
      }
    end

    let(:expected) do
      [
        {
          key: 'import_date',
          label: 'Date of import',
          value: '01 January 2090',
        },
        {
          key: 'import_destination',
          label: 'Destination',
          value: 'Northern Ireland',
        },
        {
          key: 'country_of_origin',
          label: 'Country of dispatch',
          value: 'United Kingdom',
        },
        {
          key: 'trader_scheme',
          label: 'Trader scheme',
          value: 'Yes',
        },
        {
          key: 'final_use',
          label: 'Final use',
          value: 'Yes',
        },
        {
          key: 'planned_processing',
          label: 'Processing',
          value: 'Commercial purposes',
        },
        {
          key: 'certificate_of_origin',
          label: 'Certificate of origin',
          value: 'No',
        },
        {
          key: 'customs_value',
          label: 'Customs value',
          value: '£30.00',
        },
        {
          key: 'measure_amount',
          label: 'Import quantity',
          value: '120 x 100 kg',
        },
      ]
    end

    let(:gb) { instance_double(Api::GeographicalArea) }

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

    before do
      allow(Api::GeographicalArea).to receive(:find).with('GB', :xi).and_return(gb)
      allow(gb).to receive(:description).and_return('United Kingdom')
      allow(commodity).to receive(:applicable_measure_units).and_return(applicable_measure_units)
    end

    it 'returns an array with formatted user answers from the session' do
      expect(confirmation_decorator.user_answers).to eq(expected)
    end
  end

  describe '#path_for' do
    it 'returns the correct path' do
      expect(
        confirmation_decorator.path_for(
          key: 'import_date',
        ),
      ).to eq("/duty-calculator/#{referred_service}/#{commodity_code}/import-date")
    end
  end
end
