RSpec.shared_examples 'a resource that has an enum' do |field, enums|
  subject(:resource) do
    described_class.new(field => value)
  end

  enums.each do |method_key, method_value|
    describe "##{method_key}?" do
      let(:method_name) { "#{method_key}?" }

      context "when the #{field} is set to #{method_value.first}" do
        let(:value) { method_value.first }

        it 'returns true' do
          expect(resource.public_send(method_name)).to be(true)
        end
      end

      context "when the #{field} is set to nil" do
        let(:value) { nil }

        it 'returns false' do
          expect(resource.public_send(method_name)).to be(false)
        end
      end
    end
  end
end
