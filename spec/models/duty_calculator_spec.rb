require 'rails_helper'

RSpec.describe DutyCalculator do
  subject(:calculator) { described_class.new(user_session) }

  let(:user_session) { UserSession.new(session) }

  describe '#result' do
    context 'when importing from NI to GB' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'GB',
            'country_of_origin' => 'XI',
          },
        }
      end

      it 'returns 0' do
        expect(calculator.result).to eq(0)
      end
    end

    context 'when importing from an EU country to NI' do
      let(:session) do
        {
          'answers' => {
            'import_destination' => 'XI',
            'country_of_origin' => 'RO',
          },
        }
      end

      it 'returns 0' do
        expect(calculator.result).to eq(0)
      end
    end

    context 'when importing from GB to NI' do
      context 'when there is no trade defence but a zero_mfn_duty' do
        let(:session) do
          {
            'answers' => {
              'import_destination' => 'XI',
              'country_of_origin' => 'GB',
            },
            'trade_defence' => false,
            'zero_mfn_duty' => true,
          }
        end

        it 'returns 0' do
          expect(calculator.result).to eq(0)
        end
      end

      context 'when there is a specific processing method' do
        let(:session) do
          {
            'answers' => {
              'import_destination' => 'XI',
              'country_of_origin' => 'GB',
              'planned_processing' => 'commercial_processing',
            },
          }
        end

        it 'returns 0' do
          expect(calculator.result).to eq(0)
        end
      end

      context 'when there is a certificate of origin' do
        let(:session) do
          {
            'answers' => {
              'import_destination' => 'XI',
              'country_of_origin' => 'GB',
              'certificate_of_origin' => 'yes',
            },
          }
        end

        it 'returns 0' do
          expect(calculator.result).to eq(0)
        end
      end
    end
  end
end
