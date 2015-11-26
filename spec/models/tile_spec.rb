require "spec_helper"

describe Tile do
  subject { Tile.new }
  
  describe "#empty?" do
    let(:result) { subject.empty? }
    context "when the tile has no value" do
      before { subject.instance_variable_set(:@value, nil)}
      it "is true" do
        expect(result).to eq(true)
      end
    end

    context "when the tile has a value" do
      before { subject.instance_variable_set(:@value, rand(2048))}
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
end