require "spec_helper"

describe Cell do
  subject { Cell.new }
  
  describe "#generate_value" do
    let(:result) { subject.generate_value; subject.tile}
    
    context "when generating a low value" do
      before { allow(subject).to receive(:rand).and_return Cell::PROBABILITY_OF_LOW_GENERATED_CELL }
      it "is the low value" do
        expect(result).to eq(Cell::LOW_GENERATED_CELL_VALUE)
      end
    end

    context "when generating a high value" do
      before { allow(subject).to receive(:rand).and_return Cell::PROBABILITY_OF_LOW_GENERATED_CELL + 0.01 }
      it "is the low value" do
        expect(result).to eq(Cell::HIGH_GENERATED_CELL_VALUE)
      end
    end
    
    context "when the cell already has a value" do
      before { subject.instance_variable_set(:@tile, Tile.new) }
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
      before { subject.instance_variable_set(:@tile, Tile.new)}
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
  
  # describe "#merge" do
  #   context "when the cell is empty" do
  #   end
  #
  #   context "when the cell "
  # end
end