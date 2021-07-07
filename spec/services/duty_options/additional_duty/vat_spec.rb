RSpec.describe DutyOptions::AdditionalDuty::Vat do
  subject(:service) { described_class.new(measure, user_session, additional_duty_rows) }

  describe '#option' do
    let(:commodity_source) { 'uk' }
    let(:commodity_code) { '0809400500' }
    let(:geographical_area_description) { 'All countries (1011)' }

    let(:session_attributes) do
      {
        'import_date' => '2022-01-01',
        'customs_value' => {
          'monetary_value' => '1000',
          'shipping_cost' => '40',
          'insurance_cost' => '10',
        },
        'country_of_origin' => 'IN',
        'commodity_source' => commodity_source,
        'commodity_code' => commodity_code,
      }
    end

    let(:user_session) { build(:user_session, session_attributes) }

    let(:additional_duty_rows) { [] }

    context 'when the measure is a VAT' do
      let(:measure) do
        Api::Measure.new(
          id: 2_046_828,
          measure_type: { id: '305' },
          measure_components: [measure_component],
          measure_conditions: [],
          vat: true,
          geographical_area: {
            description: geographical_area_description,
          },
          meta: { 'duty_calculator' => { 'source' => 'uk' } },
        )
      end

      let(:measure_component) do
        {
          duty_amount: 5.0,
          duty_expression_id: '01',
        }
      end

      let(:duty_html) do
        I18n.t(
          'duty_calculations.options.vat_duty_html',
          commodity_source: commodity_source.upcase,
          option_type: 'Standard rate',
          additional_code: nil,
        )
      end

      let(:expected_table) do
        {
          warning_text: nil,
          footnote: nil,
          values: [[duty_html, '5.00% * £1,050.00', '£52.50']],
          value: 52.5,
          measure_sid: 2_046_828,
          source: 'uk',
          category: :additional_duty,
        }
      end

      it 'produces a correct option' do
        expect(service.option).to eq(expected_table)
      end
    end
  end
end
