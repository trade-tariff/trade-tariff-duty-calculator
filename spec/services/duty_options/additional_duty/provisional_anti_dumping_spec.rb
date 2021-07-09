RSpec.describe DutyOptions::AdditionalDuty::ProvisionalAntiDumping do
  subject(:service) { described_class.new(measure, user_session, additional_duty_rows, nil) }

  describe '#option' do
    let(:commodity_source) { 'xi' }
    let(:commodity_code) { '0702000008' }
    let(:geographical_area_description) { 'GSP – General Framework' }

    let(:session_attributes) do
      {
        'import_date' => '2022-01-01',
        'customs_value' => {
          'monetary_value' => '1000',
          'shipping_cost' => '40',
          'insurance_cost' => '10',
        },
        'country_of_origin' => 'CN',
        'commodity_source' => commodity_source,
        'commodity_code' => commodity_code,
      }
    end

    let(:user_session) { build(:user_session, session_attributes) }

    let(:additional_duty_rows) { [] }

    context 'when the measure is a provisional anti-dumping duty' do
      let(:measure) do
        Api::Measure.new(
          id: 2_046_828,
          measure_type: { id: '552' },
          measure_components: [measure_component],
          measure_conditions: [],
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

      let(:link) do
        'https://dev.trade-tariff.service.gov.uk/xi/commodities/0702000008?country=CN#import'
      end

      let(:duty_html) do
        I18n.t(
          'duty_calculations.options.import_duty_html',
          commodity_source: 'UK',
          option_type: 'Provisional anti-dumping duty',
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
