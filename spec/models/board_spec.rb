require "spec_helper"

describe Board do
  subject { Board.new }
  let(:cells) { subject.instance_variable_get(:@cells) }
  
  describe "#empty_cells" do
    context "when there are cells with tiles" do
      let(:result) { subject.empty_cells }
      let!(:nonempty_cell) do
        cells.sample.tap do |cell|
          cell.generate_tile
        end
      end 
      
      it "returns only the cells without tiles" do
        empty_cells = cells.select { |cell| cell != nonempty_cell }
        expect(result).to eq(empty_cells)
      end
    end
  end
  
  describe "#initialize_board" do
    let(:result) { subject.initialize_board }
    let(:tiles) do
      result
      nonempty_cells = cells.reject{|cell| cell.empty?}
      nonempty_cells.map{|cell| cell.tile }
    end
    
    it "fills two cells with tiles" do
      expect(tiles.size).to eq(Board::INITIAL_CELL_COUNT)
    end
    
    it "sets the tiles to have the low or high values" do
      tiles.each do |tile|
        expect(tile.value).to satisfy do |value| 
          value == Tile::HIGH_GENERATED_VALUE || value == Tile::LOW_GENERATED_VALUE
        end
      end
    end
  end
end