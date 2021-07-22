RSpec.describe Steps::DocumentCode, :user_session do
  subject(:step) { build(:document_code, measure_type_id: measure_type_id) }

  let(:user_session) { build(:user_session, :with_commodity_information) }
  let(:commodity_source) { :uk }
  let(:commodity_code) { '7202999000' }
  let(:measure_type_id) { 117 }

  let(:filtered_commodity) do
    Api::Commodity.build(
      commodity_source,
      commodity_code,
    )
  end

  let(:applicable_vat_options) { {} }
  let(:additional_codes) { {} }

  before do
    allow(Api::Commodity).to receive(:build).and_return(filtered_commodity)
    allow(filtered_commodity).to receive(:applicable_additional_codes).and_return(additional_codes)
    allow(filtered_commodity).to receive(:applicable_vat_options).and_return(applicable_vat_options)
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[],
      )
    end
  end

  describe '#save' do
    it 'saves the document codes for uk on to the session' do
      expect { step.save }.to change(user_session, :document_code_uk).from({}).to({ '117' => ['C644', 'Y929', ''] })
    end

    it 'saves the document codes for xi on to the session' do
      expect { step.save }.to change(user_session, :document_code_xi).from({}).to({ '117' => ['N851', ''] })
    end
  end

  describe '#options_for_select' do
    let(:expected_options) do
      [
        OpenStruct.new(
          id: 'C990',
          name: 'C990 - ',
        ),
      ]
    end

    it 'returns the correct document code options for the given measure' do
      expect(step.options_for_checkboxes_for(source: 'uk')).to eq(expected_options)
    end
  end

  describe '#xi_options_for_checkboxes_without_uk' do
    let(:expected_options) do
      [
        OpenStruct.new(
          id: 'C990',
          name: 'C990 - ',
        ),
      ]
    end

    it 'returns the correct document code options for the given measure' do
      expect(step.xi_options_for_checkboxes_without_uk).to be_empty
    end
  end

  describe '#document_code_uk' do
    context 'when there are attributdef applicable_document_codeses being passed in' do
      it 'returns the additional code attribute value on the active model' do
        expect(step.document_code_uk).to eq('["C644", "Y929", ""]')
      end
    end

    context 'when there is no document code being passed in, but the value is on the session' do
      subject(:step) do
        build(
          :document_code,
          user_session: user_session,
          document_code_uk: nil,
          measure_type_id: measure_type_id,
        )
      end

      let(:measure_type_id) { '105' }
      let(:user_session) do
        build(
          :user_session,
          :with_document_codes,
          :with_commodity_information,
        )
      end

      it { is_expected.to be_valid }

      it 'returns the value from the session that corresponds to measure type 105' do
        expect(step.document_code_uk).to eq(['C644', 'Y929', ''])
      end
    end
  end

  describe '#document_code_xi' do
    context 'when there are attributes being passed in' do
      it 'returns the additional code attribute value on the active model' do
        expect(step.document_code_xi).to eq('["N851", ""]')
      end
    end

    context 'when there is no document code being passed in, but the value is on the session' do
      subject(:step) do
        build(
          :document_code,
          user_session: user_session,
          document_code_xi: nil,
          measure_type_id: measure_type_id,
        )
      end

      let(:measure_type_id) { '142' }

      let(:user_session) do
        build(
          :user_session,
          :with_document_codes,
          :with_commodity_information,
        )
      end

      it { is_expected.to be_valid }

      it 'returns the value from the session that corresponds to measure type 142' do
        expect(step.document_code_xi).to eq(['N851', ''])
      end
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:applicable_measure_units) { {} }

    before do
      allow(filtered_commodity).to receive(:applicable_measure_units).and_return(applicable_measure_units)
    end

    context 'when there is just one measure type id available and measure units are available' do
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

      it 'returns the measure_amounts path' do
        expect(step.previous_step_path).to eq(measure_amount_path)
      end
    end

    context 'when there is just one measure type id available and no measure units are available' do
      it 'returns the customs path' do
        expect(step.previous_step_path).to eq(customs_value_path)
      end
    end

    context 'when there are multiple measure type ids on the applicable_additional_codes hash' do
      subject(:step) do
        build(
          :document_code,
          user_session: user_session,
          measure_type_id: measure_type_id,
        )
      end

      let(:measure_type_id) { '105' }

      let(:additional_codes) do
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
        }
      end

      it 'returns additional_codes_path with the previous measure_type_id as argument' do
        expect(step.previous_step_path).to eq(additional_codes_path('105'))
      end
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    context 'when there is just one measure type id on the applicable_document_codes
    hash' do
      it 'returns confirm_path' do
        expect(step.next_step_path).to eq(confirm_path)
      end
    end

    context 'when there are multiple measure type ids on the applicable_document_codes hash' do
      let(:measure_type_id) { 105 }

      it 'returns document_codes_path with the next measure_type_id as argument' do
        expect(step.next_step_path).to eq(document_codes_path(117))
      end
    end

    context 'when there are less than 2 applicable vat options' do
      let(:additional_codes) do
        {
          '105' => {
            'measure_type_description' => 'third-country duty',
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
        }
      end

      let(:applicable_vat_options) do
        {
          'VATZ' => 'flibble',
        }
      end

      it 'returns confirm_path' do
        expect(step.next_step_path).to eq(confirm_path)
      end
    end

    context 'when there are more than 1 applicable vat options' do
      let(:additional_codes) do
        {
          '105' => {
            'measure_type_description' => 'third-country duty',
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
        }
      end

      let(:applicable_vat_options) do
        {
          'VATZ' => 'flibble',
          'VATR' => 'foobar',
        }
      end

      it 'returns vat_path' do
        expect(step.next_step_path).to eq(vat_path)
      end
    end
  end
end
