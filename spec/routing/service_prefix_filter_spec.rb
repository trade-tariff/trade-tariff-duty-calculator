require 'rails_helper'

RSpec.describe RoutingFilter::ServicePrefixFilter, type: :routing do
  let(:path) { "#{prefix}/duty_calculator/0101300000/import_date" }

  after do
    Thread.current[:service_choice] = nil
  end

  # rubocop:disable RSpec/MultipleExpectations
  describe 'matching routes' do
    context 'when the service choice prefix is xi' do
      let(:prefix) { '/xi' }

      it 'sets the request params service choice to the xi backend' do
        expect(get: path).to route_to(
          controller: 'wizard/steps/import_dates',
          action: 'show',
          commodity_code: '0101300000',
        )
        expect(Thread.current[:service_choice]).to eq('xi')
      end
    end

    context 'when the service choice prefix is not present' do
      let(:prefix) { nil }

      it 'does not specify the service backend' do
        expect(get: path).to route_to(
          controller: 'wizard/steps/import_dates',
          action: 'show',
          commodity_code: '0101300000',
        )
        expect(Thread.current[:service_choice]).to be_nil
      end
    end

    context 'when the service choice prefix is the same as the default' do
      let(:prefix) { '/uk' }

      it 'does not set the request params service choice' do
        expect(get: path).to route_to(
          controller: 'wizard/steps/import_dates',
          action: 'show',
          commodity_code: '0101300000',
        )
        expect(Thread.current[:service_choice]).to eq('uk')
      end
    end

    context 'when the service choice prefix is set to an unsupported service choice' do
      let(:prefix) { '/xixi' }

      it 'does not route successfully' do
        expect(get: path).not_to be_routable
        expect(Thread.current[:service_choice]).to eq(nil)
      end
    end

    context 'when the service choice prefix is the only thing in the path' do
      let(:path) { prefix.to_s }
      let(:prefix) { '/xi' }

      it 'routes to a not_found action in the errors controller' do
        expect(get: path).not_to be_routable
      end
    end
  end

  describe 'path generation' do
    let(:commodity_code) { '0101210000' }
    let(:service_default) { 'uk' }

    before do
      TradeTariffDutyCalculator::ServiceChooser.service_choice = choice
    end

    context 'when the service choice is not the default' do
      let(:choice) { 'xi' }

      it 'prepends the choice to the url' do
        result = import_date_url(commodity_code: commodity_code)

        expect(result).to eq('http://localhost/xi/duty_calculator/0101210000/import_date')
      end

      it 'prepends the choice to the path' do
        result = import_date_path(commodity_code: commodity_code)

        expect(result).to eq('/xi/duty_calculator/0101210000/import_date')
      end
    end

    context 'when the service choice is the default' do
      let(:choice) { 'uk' }

      it 'does not prepend the choice to the url' do
        result = import_date_url(commodity_code: commodity_code)

        expect(result).to eq('http://localhost/duty_calculator/0101210000/import_date')
      end

      it 'does not prepend the choice to the path' do
        result = import_date_path(commodity_code: commodity_code)

        expect(result).to eq('/duty_calculator/0101210000/import_date')
      end
    end
  end
  # rubocop:enable RSpec/MultipleExpectations
end
