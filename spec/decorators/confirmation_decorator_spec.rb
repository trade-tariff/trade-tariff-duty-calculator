RSpec.describe ConfirmationDecorator, :user_session do
  subject(:confirmation_decorator) { described_class.new(confirmation_step, commodity) }

  let(:confirmation_step) { Steps::Confirmation.new }

  let(:commodity) do
    Api::Commodity.build(
      commodity_source,
      commodity_code,
    )
  end

  let(:commodity_code) { '0702000007' }
  let(:commodity_source) { 'uk' }

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_import_date,
      :with_import_destination,
      :with_country_of_origin,
      :with_trader_scheme,
      :with_certificate_of_origin,
      :with_customs_value,
      :with_measure_amount,
      :with_additional_codes,
      :with_excise_additional_codes,
      :with_vat,
      :with_document_codes,
    )
  end

  describe 'ORDERED_STEPS' do
    it 'returns the correct steps' do
      expect(described_class::ORDERED_STEPS).to eq(
        %w[
          additional_code
          document_code
          import_date
          import_destination
          country_of_origin
          trader_scheme
          final_use
          planned_processing
          certificate_of_origin
          customs_value
          measure_amount
          excise
          vat
        ],
      )
    end
  end

  describe '#user_answers' do
    let(:expected) do
      [
        { key: 'additional_code', label: 'Additional code(s)', value: '2340, 2600, 2340, 2600' },
        { key: 'document_code', label: 'Document(s)', value: 'N851, C644, Y929' },
        { key: 'import_date', label: 'Date of import', value: '01 January 2025' },
        { key: 'import_destination', label: 'Destination', value: 'Northern Ireland' },
        { key: 'country_of_origin', label: 'Coming from', value: 'United Kingdom' },
        { key: 'trader_scheme', label: 'Trader scheme', value: 'No' },
        { key: 'certificate_of_origin', label: 'Certificate of origin', value: 'Yes' },
        { key: 'customs_value', label: 'Customs value', value: '£1,200.00' },
        { key: 'measure_amount', label: 'Import quantity', value: '100 x 100 kg' },
        { key: 'excise', label: 'Excise additional code', value: 'X444, X369' },
        { key: 'vat', label: 'Applicable VAT rate', value: 'VAT zero rate (0.0)' },
      ]
    end

    context 'when no document code has been selected' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_import_date,
          :with_import_destination,
          :with_country_of_origin,
          :with_trader_scheme,
          :with_certificate_of_origin,
          :with_customs_value,
          :with_measure_amount,
          :with_additional_codes,
          :with_excise_additional_codes,
          :with_vat,
          :with_no_document_codes_selected,
        )
      end

      let(:expected) do
        [
          { key: 'additional_code', label: 'Additional code(s)', value: '2340, 2600, 2340, 2600' },
          { key: 'document_code', label: 'Document(s)', value: 'n/a' },
          { key: 'import_date', label: 'Date of import', value: '01 January 2025' },
          { key: 'import_destination', label: 'Destination', value: 'Northern Ireland' },
          { key: 'country_of_origin', label: 'Coming from', value: 'United Kingdom' },
          { key: 'trader_scheme', label: 'Trader scheme', value: 'No' },
          { key: 'certificate_of_origin', label: 'Certificate of origin', value: 'Yes' },
          { key: 'customs_value', label: 'Customs value', value: '£1,200.00' },
          { key: 'measure_amount', label: 'Import quantity', value: '100 x 100 kg' },
          { key: 'excise', label: 'Excise additional code', value: 'X444, X369' },
          { key: 'vat', label: 'Applicable VAT rate', value: 'VAT zero rate (0.0)' },
        ]
      end

      it 'returns n/a for documents line' do
        expect(confirmation_decorator.user_answers).to eq(expected)
      end
    end

    it 'returns an array with formatted user answers from the session' do
      expect(confirmation_decorator.user_answers).to eq(expected)
    end
  end

  describe '#path_for' do
    context 'when the key is import_date' do
      it 'returns the correct path' do
        expect(
          confirmation_decorator.path_for(
            key: 'import_date',
          ),
        ).to eq("/duty-calculator/uk/#{commodity_code}/import-date")
      end
    end

    context 'when the key is additional_code' do
      it 'returns the additional_codes path with the first measure type id as param' do
        expect(
          confirmation_decorator.path_for(
            key: 'additional_code',
          ),
        ).to eq('/duty-calculator/additional-codes/105')
      end
    end
  end
end
