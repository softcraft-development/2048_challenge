require "spec_helper"

describe Tile do
  subject { Tile.new }
  
  describe "#generate_value" do
    let(:result) { subject.generate_value; subject.instance_variable_get(:@value)}
    
    context "when generating a low value" do
      before { allow(subject).to receive(:rand).and_return Tile::PROBABILITY_OF_LOW_GENERATED_TILE }
      it "is the low value" do
        expect(result).to eq(Tile::LOW_GENERATED_TILE_VALUE)
      end
    end

    context "when generating a high value" do
      before { allow(subject).to receive(:rand).and_return Tile::PROBABILITY_OF_LOW_GENERATED_TILE + 0.01 }
      it "is the low value" do
        expect(result).to eq(Tile::HIGH_GENERATED_TILE_VALUE)
      end
    end
    
    context "when the tile already has a value" do
      before { subject.instance_variable_set(:@value, rand(2048)) }
      it "raises an error" do
        expect{result}.to raise_error(/empty/)
      end
    end
  end
  
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