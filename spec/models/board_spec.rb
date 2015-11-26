require "spec_helper"

describe Board do
  subject { Board.new }
  
  describe "#empty_cells" do
    context "when there are cells with tiles" do
      let(:result) { subject.empty_cells }
      let!(:nonempty_cell) do
        row_with_nonempty_cell = subject.instance_variable_get(:@rows)[rand(Board::ROW_COUNT)]
        nonempty_cell = row_with_nonempty_cell.cell(rand(Row::CELL_COUNT))
        nonempty_cell.generate_tile
        nonempty_cell
      end 
      
      it "returns only the cells without tiles" do
        target_cells = subject.instance_variable_get(:@all_cells)
        target_cells.delete(nonempty_cell)
        
        expect(result).to eq(target_cells)
      end
    end
  end
  
  describe "#initialize_board" do
    let(:result) { subject.initialize_board }
    let(:tiles) do
      result
      tiles = subject.instance_variable_get(:@rows).reduce([]) do |tiles_for_board, row|
        row.instance_variable_get(:@cells).reduce(tiles_for_board) do |tiles_for_row, cell|
          tiles_for_row << cell.tile unless cell.empty?
          tiles_for_row
        end
        tiles_for_board
      end
    end
    
    it "fills two cells with tiles" do
      expect(tiles.size).to eq(2)
    end
    
    it "sets the tiles to have the low or high values" do
      tiles.each do |tile|
        expect(tile.value).to satisfy do |value| 
          value == Tile::HIGH_GENERATED_VALUE || value == Tile::LOW_GENERATED_VALUE
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