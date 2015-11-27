require "spec_helper"

describe CellSet do
  let(:cells) { (rand(10) + 2).times.map { Cell.new } }
  subject { CellSet.new(cells) }
  
  describe "#move_possible?" do
    let(:result) { subject.move_possible? }
    context "when there is an empty cell in the set" do
      let(:cells) { [Cell.new(Tile.new(rand(2048))), Cell.new]}
      
      it "is true" do
        expect(result).to eq(true)
      end
    end
    
    context "when there are no empty cells in the set" do
      context "and adjacent cells have a mergeable tiles" do
        let(:tile_value) { rand(2048) }
        let(:unmergable_cell) { Cell.new(Tile.new(tile_value + 1)) }
        let(:first_mergable_cell) { Cell.new(Tile.new(tile_value)) }
        let(:second_mergable_cell) { Cell.new(Tile.new(tile_value)) }
        let(:cells) {[ unmergable_cell, first_mergable_cell, second_mergable_cell]}
        
        it "is true" do
          expect(result).to eq(true)
        end
      end
      
      context "and non-adjacent cells have a mergeable tiles" do
        let(:tile_value) { rand(2048) }
        let(:unmergable_cell) { Cell.new(Tile.new(tile_value + 1)) }
        let(:first_mergable_cell) { Cell.new(Tile.new(tile_value)) }
        let(:second_mergable_cell) { Cell.new(Tile.new(tile_value)) }
        let(:cells) {[ first_mergable_cell, unmergable_cell, second_mergable_cell]}
        
        it "is false" do
          expect(result).to eq(false)
        end
      end
      
      context "and no cells are mergeable" do
        let(:tile_value) { rand(2048) }
        let(:first_unmergable_cell) { Cell.new(Tile.new(tile_value)) }
        let(:second_mergable_cell) { Cell.new(Tile.new(tile_value + 1))}
        let(:third_mergable_cell) { Cell.new(Tile.new(tile_value + 2)) }
        let(:cells) {[ first_unmergable_cell, second_mergable_cell, third_mergable_cell]}
        
        it "is false" do
          expect(result).to eq(false)
        end
      end
    end
  end
  
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