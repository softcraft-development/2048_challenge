require "spec_helper"

describe CellSet do
  let(:cells) { (rand(10) + 2).times.map { Cell.new } }
  subject { CellSet.new(cells) }
  
  describe "#reverse" do
    let(:result) { subject.reverse}

    it "returns a CellSet" do
      expect(result).to be_kind_of(CellSet)
    end

    it "returns a new instance" do
      expect(result).not_to be(subject)
    end
    
    it "sets the cells to the opposite order" do
      expect(result.cells).to eq(cells.reverse)
    end
  end
end