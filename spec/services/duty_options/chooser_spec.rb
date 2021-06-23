RSpec.describe DutyOptions::Chooser do
  subject(:service) { described_class.new(uk_option_evaluation, xi_option_evaluation, customs_value) }

  let(:customs_value) { 520 }

  let(:uk_option_evaluation) do
    {
      evaluation: {
        value: 45.56,
      },
    }
  end

  let(:xi_option_evaluation) do
    {
      evaluation: {
        value: 35.56,
      },
    }
  end

  let(:expected_option) do
    {
      evaluation: {
        value: 45.56,
      },
    }
  end

  describe '#option' do
    context 'when the delta is less or equal than 3%*customs_value' do
      it 'returns the uk option' do
        expect(service.option).to eq(expected_option)
      end
    end

    context 'when the delta is higher than 3%*customs_value' do
      let(:uk_option_evaluation) do
        {
          evaluation: {
            value: 55.56,
          },
        }
      end

      let(:expected_option) do
        {
          evaluation: {
            value: 35.56,
          },
        }
      end

      it 'returns the xi option' do
        expect(service.option).to eq(expected_option)
      end
    end
  end
end
