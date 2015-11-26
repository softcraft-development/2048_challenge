require "spec_helper"

describe Cell do
  subject { Cell.new }
  
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