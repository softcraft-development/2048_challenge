require "spec_helper"

describe CellSet do
  let(:cells) { (rand(10) + 2).times.map { Cell.new } }
  subject { CellSet.new(cells) }
  
  describe "#move" do
    let(:tile_value) { rand(2048)}
    let(:result) { subject.move }
    let(:cell_values) do
      result
      subject.cells.map do |cell|
        if cell.empty?
          nil
        else
          cell.tile.value
        end
      end
    end
    
    context "when there are no tiles" do
      let(:cells) { [Cell.new, Cell.new] }
      
      it "leaves all cells as empty" do
        expect(cell_values).to eq([nil, nil])
      end
    end
    
    context "when there is one tile" do
      let(:tile) { Tile.new(tile_value) }

      context "at the near edge" do
        let(:cells) { [Cell.new(tile), Cell.new] }
        
        it "leaves the tile in place" do
          expect(cell_values).to eq([tile_value, nil])
        end
      end
      
      context "away from the near edge" do
        let(:cells) { [Cell.new, Cell.new(tile)] }

        it "moves the tile to the near edge" do
          expect(cell_values).to eq([tile_value, nil])
        end
      end
    end
    
    context "when there are two tiles" do
      context "that are adjacent" do
        context "that are mergeable" do
          let(:cells) { [Cell.new(Tile.new(tile_value)), Cell.new(Tile.new(tile_value))] }
        
          it "merges the tiles towards the edge" do
            expect(cell_values).to eq([tile_value * 2, nil])
          end
        end
      
        context "that are not mergeable" do
          let(:first_tile) { Tile.new(tile_value)}
          let(:second_tile) { Tile.new(tile_value + 1)}
          let(:cells) { [Cell.new(first_tile), Cell.new(second_tile)] }
        
          it "leaves the tiles in place" do
            expect(cell_values).to eq([tile_value, tile_value + 1])
          end
        end
      end
      
      context "that are split by an empty cell" do
        context "that are mergeable" do
          let(:cells) { [Cell.new(Tile.new(tile_value)), Cell.new, Cell.new(Tile.new(tile_value))] }
        
          it "merges the tiles towards the edge" do
            expect(cell_values).to eq([tile_value * 2, nil, nil])
          end
        end
      
        context "that are not mergeable" do
          let(:first_tile) { Tile.new(tile_value)}
          let(:second_tile) { Tile.new(tile_value + 1)}
          let(:cells) { [Cell.new(first_tile), Cell.new, Cell.new(second_tile)] }
        
          it "moved the far tile towards the edge" do
            expect(cell_values).to eq([tile_value, tile_value + 1, nil])
          end
        end
      end
      
      context "that are preceeded by an empty cell" do
        context "that are mergeable" do
          let(:cells) { [Cell.new, Cell.new(Tile.new(tile_value)), Cell.new(Tile.new(tile_value))] }
        
          it "merges the tiles towards the edge" do
            expect(cell_values).to eq([tile_value * 2, nil, nil])
          end
        end
      
        context "that are not mergeable" do
          let(:first_tile) { Tile.new(tile_value)}
          let(:second_tile) { Tile.new(tile_value + 1)}
          let(:cells) { [Cell.new, Cell.new(first_tile), Cell.new(second_tile)] }
        
          it "moved the tiles towards the edge" do
            expect(cell_values).to eq([tile_value, tile_value + 1, nil])
          end
        end
      end
    end
    
    context "when there are three tiles" do
      let(:cells) { [Cell.new(first_tile), Cell.new(second_tile), Cell.new(third_tile)] }

      context "that are not mergeable" do
        let(:first_tile) { Tile.new(tile_value)}
        let(:second_tile) { Tile.new(tile_value + 1)}
        let(:third_tile) { Tile.new(tile_value + 2)}
        
        it "leaves the tiles in place" do
          expect(cell_values).to eq([tile_value, tile_value + 1, tile_value + 2])
        end
      end
      
      context "that are all mergeable" do
        let(:first_tile) { Tile.new(tile_value)}
        let(:second_tile) { Tile.new(tile_value)}
        let(:third_tile) { Tile.new(tile_value)}
        
        it "merges the first two tiles and moves the third to the second cell" do
          expect(cell_values).to eq([tile_value * 2, tile_value, nil])
        end
      end
      
      context "that split two mergable tiles" do
        let(:first_tile) { Tile.new(tile_value)}
        let(:second_tile) { Tile.new(tile_value + 1)}
        let(:third_tile) { Tile.new(tile_value)}
        
        it "leaves the tiles in place" do
          expect(cell_values).to eq([tile_value, tile_value + 1, tile_value])
        end
      end
    end
  end
  
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