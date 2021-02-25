require 'rails_helper'

RSpec.describe Api::GeographicalArea do
  subject(:geographical_area) do
    described_class.new(
      'id' => id,
      'geographical_area_id' => geographical_area_id,
      'description' => description,
    )
  end

  let(:service) { :uk }
  let(:id) { 'NI' }
  let(:geographical_area_id) { 'NI' }
  let(:description) { 'Nicaragua' }

  before do
    allow(Uktt::GeographicalArea).to receive(:new).and_call_original
  end

  describe '#id' do
    it 'returns the name from the attributes' do
      expect(geographical_area.id).to eq('NI')
    end
  end

  describe '#name' do
    it 'returns the name from the attributes' do
      expect(geographical_area.name).to eq('Nicaragua')
    end
  end

  describe '#european_union?' do
    context 'when the geographical_area is the EU' do
      let(:geographical_area_id) { '1013' }

      it 'returns true' do
        expect(geographical_area).to be_european_union
      end
    end

    context 'when the geographical_area is not the EU' do
      let(:geographical_area_id) { 'NI' }

      it 'returns false' do
        expect(geographical_area).not_to be_european_union
      end
    end
  end

  describe '.list_countries' do
    it 'returns a list of countries' do
      all_are_countries = described_class.list_countries(service).all? { |resource| resource.is_a?(described_class) }

      expect(all_are_countries).to be(true)
    end
  end

  describe '.european_union_members' do
    let(:expected_members)  do
      %w[AT BE BG CY CZ DE DK EE ES EU FI FR GR HR HU IE IT LT LU LV MT NL PL PT RO SE SI SK]
    end

    it 'returns all member countries of the EU' do
      members = described_class.european_union_members.map(&:id)

      expect(members).to eq(expected_members)
    end
  end
end
