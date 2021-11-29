RSpec.describe ApplicableDocumentCodesService, :user_session do
  subject(:service) { described_class.new }

  describe '#call' do
    before do
      allow(Api::Commodity).to receive(:build).and_call_original
    end

    context 'when on the deltas route' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_customs_value,
          :with_measure_amount,
          :deltas_applicable,
          commodity_code: '7202999000',
        )
      end

      let(:expected_documents) do
        {
          'uk' => {
            '105' => [
              { code: 'C644', description: 'C644 - ' },
              { code: 'Y929', description: 'Y929 - ' },
              { code: 'None', description: 'None of the above' },
            ],
            '117' => [
              { code: 'C990', description: 'C990 - ' },
              { code: 'None', description: 'None of the above' },
            ],
          },
          'xi' => {
            '105' => [
              { code: 'C644', description: 'C644 - ' },
              { code: 'Y929', description: 'Y929 - ' },
              { code: 'None', description: 'None of the above' },
            ],
            '117' => [
              { code: 'C990', description: 'C990 - ' },
              { code: 'None', description: 'None of the above' },
            ],
          },
        }
      end

      it 'fetches the xi commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'xi',
          '7202999000',
          anything,
        )
      end

      it 'fetches the uk commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'uk',
          '7202999000',
          anything,
        )
      end

      it { expect(service.call).to eq(expected_documents) }
    end

    context 'when on an xi route' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_customs_value,
          :with_measure_amount,
          commodity_source: 'xi',
          commodity_code: '7202999000',
        )
      end

      let(:expected_documents) do
        {
          'xi' => {
            '105' => [
              { code: 'C644', description: 'C644 - ' },
              { code: 'Y929', description: 'Y929 - ' },
              { code: 'None', description: 'None of the above' },
            ],
            '117' => [
              { code: 'C990', description: 'C990 - ' },
              { code: 'None', description: 'None of the above' },
            ],
          },
        }
      end

      it 'does not fetch the uk commodity' do
        service.call

        expect(Api::Commodity).not_to have_received(:build).with(
          'uk',
          '7202999000',
          anything,
        )
      end

      it 'fetches the xi commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'xi',
          '7202999000',
          anything,
        )
      end

      it { expect(service.call).to eq(expected_documents) }
    end

    context 'when on a uk route' do
      let(:user_session) do
        build(
          :user_session,
          :with_commodity_information,
          :with_customs_value,
          :with_measure_amount,
          commodity_source: 'uk',
          commodity_code: '7202999000',
        )
      end

      let(:expected_documents) do
        {
          'uk' => {
            '105' => [
              { code: 'C644', description: 'C644 - ' },
              { code: 'Y929', description: 'Y929 - ' },
              { code: 'None', description: 'None of the above' },
            ],
            '117' => [
              { code: 'C990', description: 'C990 - ' },
              { code: 'None', description: 'None of the above' },
            ],
          },
        }
      end

      it 'does not fetch the xi commodity' do
        service.call

        expect(Api::Commodity).not_to have_received(:build).with(
          'xi',
          '7202999000',
          anything,
        )
      end

      it 'fetches the uk commodity' do
        service.call

        expect(Api::Commodity).to have_received(:build).with(
          'uk',
          '7202999000',
          anything,
        )
      end

      it { expect(service.call).to eq(expected_documents) }
    end
  end
end
