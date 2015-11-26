require "spec_helper"

describe Direction do
  let(:cell_sets) do
    cell_count = rand(4) + 2
    
    (rand(4) + 2).times.map do
      cells = cell_count.times.map do 
        Cell.new
      end
      CellSet.new(cells)
    end
  end  
  
  subject { Direction.new(cell_sets) }
  
  describe "#reverse" do
    let(:result) { subject.reverse }
    
    it "returns a Direction" do
      expect(result).to be_kind_of(Direction)
    end

    it "returns a new instance" do
      expect(result).not_to be(subject)
    end
    
    it "reverses the order of the cells in the cell sets" do
      result.cell_sets.each_with_index do |cell_set, index|
        original_cell_set = subject.cell_sets[index]
        expect(cell_set.cells).to eq(original_cell_set.cells.reverse)
      end
    end
  end
end