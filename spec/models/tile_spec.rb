require "spec_helper"

describe Tile do
  subject { Tile.new }
  
  describe "::generate" do
    let(:result) { Tile.generate }
    
    it "returns a Tile" do
      expect(result).to be_kind_of(Tile)
    end
    
    context "when generating a low value" do
      before { allow(Tile).to receive(:rand).and_return Tile::PROBABILITY_OF_LOW_GENERATED_VALUE }
      it "is the low value" do
        expect(result.value).to eq(Tile::LOW_GENERATED_VALUE)
      end
    end

    context "when generating a high value" do
      before { allow(Tile).to receive(:rand).and_return Tile::PROBABILITY_OF_LOW_GENERATED_VALUE + 0.01 }
      it "is the low value" do
        expect(result.value).to eq(Tile::HIGH_GENERATED_VALUE)
      end
    end
  end
end