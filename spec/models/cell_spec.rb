require "spec_helper"

describe Cell do
  subject { Cell.new }
  
  describe "#value" do
    let(:result) { subject.value }
    
    context "when the cell is empty" do
      subject { Cell.new(nil) }
      it "is nil" do
        expect(result).to eq(nil)
      end
    end
    
    context "when the cell has a tile" do
      let(:tile) { Tile.new(rand(2048)) }
      subject { Cell.new(tile) }
      it "is the tile value" do
        expect(result).to eq(tile.value)
      end
    end
  end
  
  describe "#win?" do
    let(:result) { subject.win?}
    
    context "when the cell is empty" do
      subject { Cell.new(nil) }
      it "is false" do
        expect(result).to eq(false)
      end
    end
    
    context "when the cell tile has the goal value" do
      subject { Cell.new(Tile.new(Cell::GOAL)) }
      it "is true" do
        expect(result).to eq(true)
      end
    end
    
    context "when the cell tile does not have the goal value" do
      subject { Cell.new(Tile.new(Cell::GOAL - 1)) }
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
  
  describe "#merge" do
    let(:tile_value) { rand(2048) }
    let(:tile) { Tile.new(tile_value) }
    let(:result) { subject.merge(tile) }
    
    context "when the cell is empty" do
      subject { Cell.new(nil) }
      
      it "assigns the tile to the cell" do
        result
        expect(subject.tile).to be(tile)
      end
    end
    
    context "when the cell has a preexisting tile" do
      subject { Cell.new(preexisting_tile) }
      context "and the tiles share a value" do
        let(:preexisting_tile) { Tile.new(tile.value)}
        
        it "preserves the preexisting tile instance" do
          result
          expect(subject.tile).to be(preexisting_tile)
        end
        
        it "combines the value of the tiles" do
          result
          expect(subject.tile.value).to eq(tile_value * 2)
        end
      end

      context "and the tiles do not share a value" do
        let(:preexisting_tile) { Tile.new(tile.value + 1)}
        it "raises an error" do
          expect{result}.to raise_error(/Cannot merge/i)
        end
      end
    end
  end
  
  describe "#mergable_with?" do
    let(:tile) { Tile.new(rand(2048)) }
    let(:result) { subject.mergeable_with?(tile) }
    
    context "when the cell is empty" do
      before { subject.instance_variable_set(:@tile, nil)}
      
      it "is true" do
        expect(result).to eq(true)
      end
    end

    context "when the cell has a tile that matches the tile value" do
      before { subject.instance_variable_set(:@tile, Tile.new(tile.value) )}
      
      it "is true" do
        expect(result).to eq(true)
      end
    end

    context "when the cell has a tile does not match the tile value" do
      before { subject.instance_variable_set(:@tile, Tile.new(tile.value + 1) )}
      
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
  
  describe "#generate_tile" do
    let(:result) { subject.generate_tile; subject.tile}
    
    context "when the cell already has a value" do
      before { subject.instance_variable_set(:@tile, Tile.new(0)) }
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
      before { subject.instance_variable_set(:@tile, Tile.new(0))}
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
end