require 'rails_helper'

RSpec.describe TradeTariffDutyCalculator::ServiceChooser do
  around do |example|
    Thread.current[:service_choice] = choice
    example.run
    Thread.current[:service_choice] = nil
  end

  let(:choice) { nil }

  describe '.service_choices' do
    it 'returns a Hash of url options for the services' do
      expect(described_class.service_choices).to eq(
        'uk' => 'http://localhost:3018',
        'xi' => 'http://localhost:3019',
      )
    end
  end

  describe '.service_choice=' do
    it 'assigns the service choice to the current Thread' do
      expect { described_class.service_choice = 'xi' }
        .to change { Thread.current[:service_choice] }
        .from(nil)
        .to('xi')
    end
  end

  describe '.api_host' do
    context 'when the service choice does not have a corresponding url' do
      let(:choice) { 'foo' }

      it 'returns the default service choice url' do
        expect(described_class.api_host).to eq('http://localhost:3018')
      end
    end

    context 'when the service choice has a corresponding url' do
      let(:choice) { 'xi' }

      it 'returns the service choice url' do
        expect(described_class.api_host).to eq('http://localhost:3019')
      end
    end
  end

  describe '.xi?' do
    context 'when the service choice is xi' do
      let(:choice) { 'xi' }

      it 'returns the default service choice url' do
        expect(described_class.xi?).to be(true)
      end
    end

    context 'when the service choice is uk' do
      let(:choice) { 'uk' }

      it 'returns the default service choice url' do
        expect(described_class.xi?).to eq(false)
      end
    end
  end

  describe '.uk?' do
    context 'when the service choice is xi' do
      let(:choice) { 'xi' }

      it 'returns the default service choice url' do
        expect(described_class.uk?).to be(false)
      end
    end

    context 'when the service choice is uk' do
      let(:choice) { 'uk' }

      it 'returns the default service choice url' do
        expect(described_class.uk?).to eq(true)
      end
    end
  end
end
