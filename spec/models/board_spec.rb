require "spec_helper"

describe Board do
  subject { Board.new }
  
  describe "#initialize_board" do
    let(:result) { subject.initialize_board }
    let(:nonempty_cells) do
      result
      nonempty_cells = subject.instance_variable_get(:@rows).reduce([]) do |nonempty_for_row, row|
        row.instance_variable_get(:@cells).reduce(nonempty_for_row) do |nonempty_for_cell, cell|
          nonempty_for_cell << cell unless cell.empty?
          nonempty_for_cell
        end
      end
    end
    
    it "fills two cells with values" do
      expect(nonempty_cells.size).to eq(2)
    end
    
    it "sets the nonempty cells to have the low or high values" do
      nonempty_cells.each do |cell|
        expect(cell.tile).to satisfy do |value| 
          value == Cell::HIGH_GENERATED_CELL_VALUE || value == Cell::LOW_GENERATED_CELL_VALUE
        end
      end
    end
  end
  
  describe "#cell" do
    let(:result) { subject.cell(absolute_cell_number)}
    
    context "when the cell number corresponds to a cell anywhere in the board" do
      let(:row_number) { rand(Board::ROW_COUNT) }
      let(:row_cell_number) { rand(Row::CELL_COUNT) }
      let(:absolute_cell_number) { (row_number * 4) + row_cell_number }
      
      it "returns the cell for the row and column" do
        row = subject.instance_variable_get(:@rows)[row_number]
        target_cell = row.instance_variable_get(:@cells)[row_cell_number]
        
        expect(result).to be(target_cell)
      end
    end
  end
end