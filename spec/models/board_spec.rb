require "spec_helper"

describe Board do
  subject { Board.new }

  it "creates cells for each intersection of row and column" do
    expect(subject.cells.size).to eq(Board::ROW_COUNT * Board::COLUMN_COUNT)
  end
  
  [:right, :left, :down, :up].each do |direction_name|
    context "for the direction named #{direction_name}" do
      it "creates a Direction" do
        expect(subject.directions[direction_name]).to be_kind_of(Direction)
      end
    end
  end
  
  it "sets the first cell set in the left direction to the first four cells" do
    expect(subject.directions[:left].cell_sets.first.cells).to eq(subject.cells[0..3])
  end

  it "sets the first cell set in the down direction to the first, fifth, nineth, and thirteenth cells" do
    expect(subject.directions[:up].cell_sets.first.cells).to eq([subject.cells[0], subject.cells[4], subject.cells[8], subject.cells[12]])
  end
  
  {:up => :down, :left => :right}.each do |direction, opposite_direction|
    it "sets the #{opposite_direction} cells to be the reverse of the #{direction} cells" do
      subject.directions[direction].cell_sets.each_with_index do |cell_set, index|
        equivalent_cells = subject.directions[opposite_direction].cell_sets[index].cells
        expect(cell_set.cells.reverse).to eq(equivalent_cells)
      end
    end
  end
  
  describe "#empty_cells" do
    context "when there are cells with tiles" do
      let(:result) { subject.empty_cells }
      let!(:nonempty_cell) do
        subject.cells.sample.tap do |cell|
          cell.generate_tile
        end
      end 
      
      it "returns only the cells without tiles" do
        empty_cells = subject.cells.select { |cell| cell != nonempty_cell }
        expect(result).to eq(empty_cells)
      end
    end
  end
  
  describe "#initialize_board" do
    let(:result) { subject.initialize_board }
    let(:tiles) do
      result
      nonempty_cells = subject.cells.reject{|cell| cell.empty?}
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