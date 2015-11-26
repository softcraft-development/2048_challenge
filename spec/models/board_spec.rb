require "spec_helper"

describe Board do
  subject { Board.new }
  
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