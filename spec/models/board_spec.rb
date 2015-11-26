require "spec_helper"

describe Board do
  subject { Board.new }
  
  describe "#initialize_board" do
    let(:result) { subject.initialize_board }
    let(:nonempty_tiles) do
      result
      nonempty_tiles = subject.instance_variable_get(:@rows).reduce([]) do |nonempty_for_row, row|
        row.instance_variable_get(:@tiles).reduce(nonempty_for_row) do |nonempty_for_tile, tile|
          nonempty_for_tile << tile unless tile.empty?
          nonempty_for_tile
        end
      end
    end
    
    it "fills two tiles with values" do
      expect(nonempty_tiles.size).to eq(2)
    end
    
    it "sets the nonempty tiles to have the low or high values" do
      nonempty_tiles.each do |tile|
        expect(tile.instance_variable_get(:@value)).to satisfy do |value| 
          value == Tile::HIGH_GENERATED_TILE_VALUE || value == Tile::LOW_GENERATED_TILE_VALUE
        end
      end
    end
  end
  
  describe "#tile" do
    let(:result) { subject.tile(absolute_tile_number)}
    
    context "when the tile number corresponds to a tile anywhere in the board" do
      let(:row_number) { rand(Board::ROW_COUNT) }
      let(:row_tile_number) { rand(Row::TILE_COUNT) }
      let(:absolute_tile_number) { (row_number * 4) + row_tile_number }
      
      it "returns the tile for the row and column" do
        row = subject.instance_variable_get(:@rows)[row_number]
        target_tile = row.instance_variable_get(:@tiles)[row_tile_number]
        
        expect(result).to be(target_tile)
      end
    end
  end
end