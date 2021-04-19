RSpec.describe UserSession do
  subject(:user_session) { described_class.new(session) }

  let(:session) { {} }

  describe '#import_date' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.import_date).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'answers' => {
            Wizard::Steps::ImportDate.id => '2025-01-01',
          },
        }
      end

      let(:expected_date) { Date.parse('2025-01-01') }

      it 'returns the value from the session' do
        expect(user_session.import_date).to eq(expected_date)
      end
    end
  end

  describe '#import_date=' do
    let(:expected_date) { '2025-01-01' }

    it 'sets the key on the session' do
      user_session.import_date = '2025-01-01'

      expect(session['answers'][Wizard::Steps::ImportDate.id]).to eq(expected_date)
    end
  end

  describe '#import_destination' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.import_destination).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'answers' => {
            Wizard::Steps::ImportDestination.id => 'ni',
          },
        }
      end

      let(:expected_country) { 'ni' }

      it 'returns the value from the session' do
        expect(user_session.import_destination).to eq(expected_country)
      end
    end
  end

  describe '#import_destination=' do
    let(:expected_country) { 'ni' }

    it 'sets the key on the session' do
      user_session.import_destination = 'ni'

      expect(session['answers'][Wizard::Steps::ImportDestination.id]).to eq(expected_country)
    end
  end

  describe '#trader_scheme' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.trader_scheme).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'answers' => {
            Wizard::Steps::TraderScheme.id => 'yes',
          },
        }
      end

      let(:expected_response) { 'yes' }

      it 'returns the value from the session' do
        expect(user_session.trader_scheme).to eq(expected_response)
      end
    end
  end

  describe '#trader_scheme=' do
    let(:expected_response) { 'yes' }

    it 'sets the key on the session' do
      user_session.trader_scheme = 'yes'

      expect(session['answers'][Wizard::Steps::TraderScheme.id]).to eq(expected_response)
    end
  end

  describe '#final_use' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.final_use).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'answers' => {
            Wizard::Steps::FinalUse.id => 'yes',
          },
        }
      end

      let(:expected_response) { 'yes' }

      it 'returns the value from the session' do
        expect(user_session.final_use).to eq(expected_response)
      end
    end
  end

  describe '#final_use=' do
    let(:expected_response) { 'yes' }

    it 'sets the key on the session' do
      user_session.final_use = 'yes'

      expect(session['answers'][Wizard::Steps::FinalUse.id]).to eq(expected_response)
    end
  end

  describe '#planned_processing' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.planned_processing).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'answers' => {
            Wizard::Steps::PlannedProcessing.id => 'without_any_processing',
          },
        }
      end

      let(:expected_response) { 'without_any_processing' }

      it 'returns the value from the session' do
        expect(user_session.planned_processing).to eq(expected_response)
      end
    end
  end

  describe '#planned_processing=' do
    let(:expected_response) { 'without_any_processing' }

    it 'sets the key for without any processing in the session' do
      user_session.planned_processing = 'without_any_processing'

      expect(session['answers'][Wizard::Steps::PlannedProcessing.id]).to eq(expected_response)
    end
  end

  describe '#certificate_of_origin' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.certificate_of_origin).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'answers' => {
            Wizard::Steps::CertificateOfOrigin.id => 'yes',
          },
        }
      end

      let(:expected_response) { 'yes' }

      it 'returns the value from the session' do
        expect(user_session.certificate_of_origin).to eq(expected_response)
      end
    end
  end

  describe '#certificate_of_origin=' do
    let(:expected_response) { 'yes' }

    it 'sets the key on the session' do
      user_session.certificate_of_origin = 'yes'

      expect(session['answers'][Wizard::Steps::CertificateOfOrigin.id]).to eq(expected_response)
    end
  end

  describe '#country_of_origin' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.country_of_origin).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'answers' => {
            Wizard::Steps::CountryOfOrigin.id => '1234',
          },
        }
      end

      let(:expected_country) { '1234' }

      it 'returns the value from the session' do
        expect(user_session.country_of_origin).to eq(expected_country)
      end
    end
  end

  describe '#country_of_origin=' do
    let(:expected_country) { '1234' }

    it 'sets the key on the session' do
      user_session.country_of_origin = '1234'

      expect(session['answers'][Wizard::Steps::CountryOfOrigin.id]).to eq(expected_country)
    end
  end

  describe '#trade_defence' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.trade_defence).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'trade_defence' => true,
        }
      end

      it 'returns the value from the session' do
        expect(user_session.trade_defence).to eq(true)
      end
    end
  end

  describe '#trade_defence=' do
    it 'sets the key on the session' do
      user_session.trade_defence = true

      expect(session['trade_defence']).to eq(true)
    end
  end

  describe '#zero_mfn_duty=' do
    it 'sets the key on the session' do
      user_session.zero_mfn_duty = true

      expect(session['zero_mfn_duty']).to eq(true)
    end
  end

  describe '#zero_mfn_duty' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.zero_mfn_duty).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'zero_mfn_duty' => true,
        }
      end

      it 'returns the value from the session' do
        expect(user_session.zero_mfn_duty).to eq(true)
      end
    end
  end

  describe '#insurance_cost' do
    let(:session) do
      {
        'answers' => {
          Wizard::Steps::CustomsValue.id => {
            'monetary_value' => '12_000',
            'shipping_cost' => '1_200',
            'insurance_cost' => '340',
          },
        },
      }
    end

    it 'returns the correct value from the session' do
      expect(user_session.insurance_cost).to eq('340')
    end
  end

  describe '#shipping_cost' do
    let(:session) do
      {
        'answers' => {
          Wizard::Steps::CustomsValue.id => {
            'monetary_value' => '12_000',
            'shipping_cost' => '1_200',
            'insurance_cost' => '340',
          },
        },
      }
    end

    it 'returns the correct value from the session' do
      expect(user_session.shipping_cost).to eq('1_200')
    end
  end

  describe '#monetary_value' do
    let(:session) do
      {
        'answers' => {
          Wizard::Steps::CustomsValue.id => {
            'monetary_value' => '12_000',
            'shipping_cost' => '1_200',
            'insurance_cost' => '340',
          },
        },
      }
    end

    it 'returns the correct value from the session' do
      expect(user_session.monetary_value).to eq('12_000')
    end
  end

  describe '#customs_value=' do
    let(:value) do
      {
        'monetary_value' => 12_000,
        'shipping_cost' => 1_200,
        'insurance_cost' => 340,
      }
    end

    it 'stores the hash on the session' do
      user_session.customs_value = value

      expect(session['answers'][Wizard::Steps::CustomsValue.id]).to eq(value)
    end
  end

  describe '#measure_amount' do
    let(:session) do
      {
        'answers' => {
          Wizard::Steps::MeasureAmount.id => { foo: :bar },
        },
      }
    end

    it 'returns the correct value from the session' do
      expect(user_session.measure_amount).to eq(foo: :bar)
    end
  end

  describe '#measure_amount=' do
    let(:value) { {} }

    it 'stores the hash on the session' do
      user_session.measure_amount = value

      expect(session['answers'][Wizard::Steps::MeasureAmount.id]).to eq(value)
    end
  end

  describe '#commodity_code' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.commodity_code).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'commodity_code' => '1111111111',
        }
      end

      it 'returns the value from the session' do
        expect(user_session.commodity_code).to eq('1111111111')
      end
    end
  end

  describe '#commodity_code=' do
    it 'sets the key on the session' do
      user_session.commodity_code = '1111111111'

      expect(session['commodity_code']).to eq('1111111111')
    end
  end

  describe '#commodity_source' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.commodity_source).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'commodity_source' => 'uk',
        }
      end

      it 'returns the value from the session' do
        expect(user_session.commodity_source).to eq('uk')
      end
    end
  end

  describe '#commodity_source=' do
    it 'sets the key on the session' do
      user_session.commodity_source = 'uk'

      expect(session['commodity_source']).to eq('uk')
    end
  end

  describe '#referred_service' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.referred_service).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          'referred_service' => 'uk',
        }
      end

      it 'returns the value from the session' do
        expect(user_session.referred_service).to eq('uk')
      end
    end
  end

  describe '#referred_service=' do
    it 'sets the key on the session' do
      user_session.referred_service = 'uk'

      expect(session['referred_service']).to eq('uk')
    end
  end

  describe '#ni_to_gb_route?' do
    context 'when import country is GB and origin country is NI' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'UK',
            'country_of_origin' => 'XI',
          },
        }
      end

      it 'returns true' do
        expect(user_session.ni_to_gb_route?).to be true
      end
    end

    it 'returns false otherwise' do
      expect(user_session.ni_to_gb_route?).to be false
    end
  end

  describe '#eu_to_ni_route?' do
    context 'when import country is NI and origin country is a EU Member' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'XI',
            'country_of_origin' => 'RO',
          },
        }
      end

      it 'returns true' do
        expect(user_session.eu_to_ni_route?).to be true
      end
    end

    it 'returns false otherwise' do
      expect(user_session.eu_to_ni_route?).to be false
    end
  end

  describe '#gb_to_ni_route?' do
    context 'when import country is XI and origin country is GB' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'XI',
            'country_of_origin' => 'GB',
          },
        }
      end

      it 'returns true' do
        expect(user_session.gb_to_ni_route?).to be true
      end
    end

    it 'returns false otherwise' do
      expect(user_session.gb_to_ni_route?).to be false
    end
  end

  describe '#row_to_gb_route?' do
    context 'when import country is UK and origin country is anything but XI' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'UK',
            'country_of_origin' => 'RO',
          },
        }
      end

      it 'returns true' do
        expect(user_session.row_to_gb_route?).to be true
      end
    end

    it 'returns false otherwise' do
      expect(user_session.row_to_gb_route?).to be false
    end
  end
end
