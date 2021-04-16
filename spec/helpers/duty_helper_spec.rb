RSpec.describe DutyHelper do
  before do
    allow(helper).to receive(:filtered_commodity).and_return(commodity)
    allow(helper).to receive(:commodity_url).and_return(commodity_url)
    allow(helper).to receive(:commodity_code)
  end

  let(:commodity) { instance_double('Api::Commodity', company_defensive_measures?: company_defensive_measures) }

  let(:company_defensive_measures) { true }
  let(:commodity_url) { 'https://dev.trade-tariff.service.gov.uk/commodities/1234567890' }

  describe '#company_warning_text' do
    context 'when the commodity has defensive measures for the company in place' do
      let(:company_defensive_measures) { true }

      let(:expected_warning_text) do
        'There are trade defence measures applicable for the import of this commodity from certain companies. Please view the <a href="https://dev.trade-tariff.service.gov.uk/commodities/1234567890">commodity page</a> for more information.'
      end

      it { expect(helper.company_warning_text).to eq(expected_warning_text) }
    end

    context 'when the commodity does not have defensive measures for the company in place' do
      let(:company_defensive_measures) { false }

      it { expect(helper.company_warning_text).to be_nil }
    end
  end
end
