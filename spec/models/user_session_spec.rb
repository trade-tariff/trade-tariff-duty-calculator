require 'rails_helper'

RSpec.describe Wizard::Steps::UserSession do
  subject(:user_session) { described_class.new(session) }

  let(:session) { {} }

  describe '#import_date' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.import_date).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          Wizard::Steps::ImportDate::STEP_ID => '2025-01-01',
        }
      end

      let(:expected_date) { Date.parse('2025-01-01') }

      it 'returns the date from the session' do
        expect(user_session.import_date).to eq(expected_date)
      end
    end
  end

  describe '#import_date=' do
    let(:expected_date) { '2025-01-01' }

    it 'sets the key on the session' do
      user_session.import_date = '2025-01-01'

      expect(session[Wizard::Steps::ImportDate::STEP_ID]).to eq(expected_date)
    end
  end

  describe '#import_destination' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.import_destination).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          Wizard::Steps::ImportDestination::STEP_ID => 'ni',
        }
      end

      let(:expected_country) { 'ni' }

      it 'returns the date from the session' do
        expect(user_session.import_destination).to eq(expected_country)
      end
    end
  end

  describe '#import_destination=' do
    let(:expected_country) { 'ni' }

    it 'sets the key on the session' do
      user_session.import_destination = 'ni'

      expect(session[Wizard::Steps::ImportDestination::STEP_ID]).to eq(expected_country)
    end
  end

  describe '#trader_scheme' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.trader_scheme).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          Wizard::Steps::TraderScheme::STEP_ID => '1',
        }
      end

      let(:expected_response) { '1' }

      it 'returns the date from the session' do
        expect(user_session.trader_scheme).to eq(expected_response)
      end
    end
  end

  describe '#trader_scheme=' do
    let(:expected_response) { '1' }

    it 'sets the key on the session' do
      user_session.trader_scheme = '1'

      expect(session[Wizard::Steps::TraderScheme::STEP_ID]).to eq(expected_response)
    end
  end

  describe '#country_of_origin' do
    it 'returns nil if the key is not on the session' do
      expect(user_session.country_of_origin).to be nil
    end

    context 'when the key is present on the session' do
      let(:session) do
        {
          Wizard::Steps::CountryOfOrigin::STEP_ID => '1234',
        }
      end

      let(:expected_country) { '1234' }

      it 'returns the date from the session' do
        expect(user_session.country_of_origin).to eq(expected_country)
      end
    end
  end

  describe '#country_of_origin=' do
    let(:expected_country) { '1234' }

    it 'sets the key on the session' do
      user_session.country_of_origin = '1234'

      expect(session[Wizard::Steps::CountryOfOrigin::STEP_ID]).to eq(expected_country)
    end
  end

  describe '#insurance_cost' do
    let(:session) do
      {
        Wizard::Steps::CustomsValue::STEP_ID => {
          'monetary_value' => '12_000',
          'shipping_cost' => '1_200',
          'insurance_cost' => '340',
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
        Wizard::Steps::CustomsValue::STEP_ID => {
          'monetary_value' => '12_000',
          'shipping_cost' => '1_200',
          'insurance_cost' => '340',
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
        Wizard::Steps::CustomsValue::STEP_ID => {
          'monetary_value' => '12_000',
          'shipping_cost' => '1_200',
          'insurance_cost' => '340',
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
        'monetary_value' => '12_000',
        'shipping_cost' => '1_200',
        'insurance_cost' => '340',
      }
    end

    it 'stores the hash on the session' do
      user_session.customs_value = value

      expect(session[Wizard::Steps::CustomsValue::STEP_ID]).to eq(value)
    end
  end

  describe '#ni_to_gb_route?' do
    context 'when import country is GB and origin country is NI' do
      let(:session) do
        {
          '2' => 'GB',
          '3' => 'XI',
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
          '2' => 'XI',
          '3' => 'RO',
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
          '2' => 'XI',
          '3' => 'GB',
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
end
