require 'rails_helper'

RSpec.describe Wizard::Steps::Base do
  subject(:base) { described_class.new(session) }

  let(:session) { { key: 'value' } }

  describe '#persisted?' do
    it 'is set to false' do
      expect(base.persisted?).to be false
    end
  end

  describe 'access to session' do
    it 'has access the session' do
      expect(base.session).to eq(session)
    end
  end
end
