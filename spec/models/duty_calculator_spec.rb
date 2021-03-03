require 'rails_helper'

RSpec.describe DutyCalculator do
  subject(:calculator) { described_class.new(user_session) }

  let(:user_session) { UserSession.new(session) }

  describe '#result' do
    context 'when importing from NI to GB' do
      let(:session) do
        {
          'import_destination' => 'GB',
          'country_of_origin' => 'XI',
        }
      end

      it 'returns 0' do
        expect(calculator.result).to eq(0)
      end
    end

    context 'when importing from an EU country to NI' do
      let(:session) do
        {
          'import_destination' => 'XI',
          'country_of_origin' => 'RO',
        }
      end

      it 'returns 0' do
        expect(calculator.result).to eq(0)
      end
    end
  end
end
