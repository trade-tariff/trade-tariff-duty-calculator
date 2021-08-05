RSpec.describe ExciseHelper do
  describe '#sanitized_excise_hint' do
    before { assign(:step, step) }

    let(:step) { instance_double('Steps::Excise', small_brewers_relief?: small_brewers_relief) }

    context 'when the excise additional codes do not have small brewers relief' do
      let(:small_brewers_relief) { false }

      it { expect(helper.sanitized_excise_hint).to be_html_safe }
      it { expect(helper.sanitized_excise_hint).not_to match(/SBR/) }
    end

    context 'when the excise additional codes have small brewers relief' do
      let(:small_brewers_relief) { true }

      it { expect(helper.sanitized_excise_hint).to be_html_safe }
      it { expect(helper.sanitized_excise_hint).to match(/SBR/) }
    end
  end
end
