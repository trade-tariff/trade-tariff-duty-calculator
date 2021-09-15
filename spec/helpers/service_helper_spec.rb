RSpec.describe ServiceHelper, :user_session do
  before do
    allow(Rails.configuration).to receive(:trade_tariff_frontend_url).and_return(frontend_url)

    allow(controller).to receive(:params).and_return(params)
  end

  let(:params) do
    ActionController::Parameters.new(
      referred_service: service,
    ).permit(:referred_service)
  end

  let(:service) { 'uk' }

  let(:frontend_url) { 'https://dev.trade-tariff.service.gov.uk' }

  let(:user_session) { build(:user_session) }

  describe '#title' do
    context 'when referred_service is xi' do
      let(:service) { 'xi' }

      it { expect(helper.title).to eq('Northern Ireland Online Tariff') }
    end

    context 'when referred_service is uk' do
      let(:service) { 'uk' }

      it { expect(helper.title).to eq('UK Integrated Online Tariff') }
    end
  end

  describe '#header' do
    context 'when referred_service is xi' do
      let(:service) { 'xi' }

      it { expect(helper.header).to eq('Northern Ireland Online Tariff') }
    end

    context 'when referred_service is uk' do
      let(:service) { 'uk' }

      it { expect(helper.header).to eq('UK Integrated Online Tariff') }
    end

    context 'when referred_service is not set at all' do
      let(:service) { nil }

      it { expect(helper.header).to eq('UK Integrated Online Tariff') }
    end
  end

  describe '#trade_tariff_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff url' do
        expect(helper.trade_tariff_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/sections',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the staging trade tariff url' do
        expect(helper.trade_tariff_url).to eq('#')
      end
    end

    context 'when service choice is XI' do
      let(:service) { 'xi' }

      it 'returns the dev trade tariff url for XI' do
        expect(helper.trade_tariff_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/xi/sections',
        )
      end
    end
  end

  describe '#a_to_z_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff a to z url' do
        expect(helper.a_to_z_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/a-z-index/a',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff a to z url' do
        expect(helper.a_to_z_url).to eq('#')
      end
    end
  end

  describe '#tools_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff tools url' do
        expect(helper.tools_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/tools',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff tools url' do
        expect(helper.tools_url).to eq('#')
      end
    end
  end

  describe '#help_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff tools url' do
        expect(helper.help_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/help',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff tools url' do
        expect(helper.help_url).to eq('#')
      end
    end
  end

  describe '#previous_service_url' do
    let(:commodity_code) { '0702000007' }
    let(:user_session) { build(:user_session) }

    context 'when redirect_to is set' do
      let(:user_session) { build(:user_session, redirect_to: 'https://example.com/chieg') }

      it { expect(helper.previous_service_url(commodity_code)).to eq('https://example.com/chieg') }
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff tools url' do
        expect(helper.previous_service_url(commodity_code)).to eq(
          "https://dev.trade-tariff.service.gov.uk/commodities/#{commodity_code}",
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff tools url' do
        expect(helper.previous_service_url(commodity_code)).to eq('#')
      end
    end
  end

  describe '#feedback_url' do
    context 'when TRADE_TARIFF_FRONTEND_URL is set' do
      it 'returns the dev trade tariff tools url' do
        expect(helper.feedback_url).to eq(
          'https://dev.trade-tariff.service.gov.uk/feedback',
        )
      end
    end

    context 'when TRADE_TARIFF_FRONTEND_URL is not set' do
      let(:frontend_url) { nil }

      it 'returns the dev trade tariff tools url' do
        expect(helper.feedback_url).to eq('#')
      end
    end
  end
end
