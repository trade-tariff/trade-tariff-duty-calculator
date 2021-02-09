require 'rails_helper'

RSpec.describe Wizard::Steps::Base do
  subject(:base) { described_class.new(session, attributes) }

  let(:session) { { key: 'value' } }
  let(:attributes) { {} }

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

  describe 'access to attributes' do
    let(:attributes) do
      {
        key: 'value',
      }
    end

    it 'has access to attributes' do
      expect(base.attributes).to eq(attributes)
    end
  end
end
