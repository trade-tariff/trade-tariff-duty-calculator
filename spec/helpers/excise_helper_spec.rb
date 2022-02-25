RSpec.describe ExciseHelper do
  describe '#excise_hint' do
    subject(:excise_hint) { helper.excise_hint(small_brewers_relief:) }

    context 'when the excise additional codes do not have small brewers relief' do
      let(:small_brewers_relief) { false }

      it { is_expected.to be_html_safe }
      it { is_expected.not_to match(/SBR/) }
    end

    context 'when the excise additional codes have small brewers relief' do
      let(:small_brewers_relief) { true }

      it { is_expected.to be_html_safe }
      it { is_expected.to match(/SBR/) }
    end
  end
end
