require "spec_helper"

describe Cell do
  subject { Cell.new }
  
  describe "#mergable_with?" do
    let(:tile) { Tile.new(rand(2048)) }
    let(:result) { subject.mergeable_with?(tile) }
    
    context "when the cell is empty" do
      before { subject.instance_variable_set(:@tile, nil)}
      
      it "is true" do
        expect(result).to eq(true)
      end
    end

    context "when the cell has a tile that matches the tile value" do
      before { subject.instance_variable_set(:@tile, Tile.new(tile.value) )}
      
      it "is true" do
        expect(result).to eq(true)
      end
    end

    context "when the cell has a tile does not match the tile value" do
      before { subject.instance_variable_set(:@tile, Tile.new(tile.value + 1) )}
      
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
  
  describe "#generate_tile" do
    let(:result) { subject.generate_tile; subject.tile}
    
    context "when the cell already has a value" do
      before { subject.instance_variable_set(:@tile, Tile.new(0)) }
      it "raises an error" do
        expect{result}.to raise_error(/empty/)
      end
    end
  end
  
  describe "#empty?" do
    let(:result) { subject.empty? }
    context "when the cell has no value" do
      before { subject.instance_variable_set(:@tile, nil)}
      it "is true" do
        expect(result).to eq(true)
      end
    end

    context "when the cell has a value" do
      before { subject.instance_variable_set(:@tile, Tile.new(0))}
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
end