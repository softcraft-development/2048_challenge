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

  it "sets the first cell set in the up direction to the first, fifth, nineth, and thirteenth cells" do
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
  
  def test_board(before, after, direction)
    index = 0
    before.each do |row|
      row.each do |cell_value|
        if cell_value
          subject.cells[index].tile = Tile.new(cell_value)
        else
          subject.cells[index].tile = nil
        end
        index += 1
      end
    end
    
    subject.directions[direction].move
    
    index = 0
    after.each do |row|
      row.each do |cell_value|
        cell = subject.cells[index]
        if cell_value
          expect(cell.tile.value).to eq(cell_value)
        else
          expect(cell.tile).to eq(nil)
        end
        index += 1
      end
    end
  end
  
  it "makes the example left move" do
    before = [
      [2,	2, nil, 4],
      [4, 2, 4, 4],
      [2, 2, nil, 2],
      [nil, nil, nil, nil]
    ]
    after = [
      [4, 4, nil, nil],
      [4, 2, 8, nil],
      [4, 2, nil, nil],
    ]
    test_board(before, after, :left)
  end

  it "makes the example right move" do
    before = [
      [4, 2, nil, 2],
      [4, 2, 4, 4],
      [2, 2, nil, 2],
      [nil, nil, nil, nil]
    ]
    after = [
      [nil, nil, 4, 4],
      [nil, 4, 2, 8],
      [nil, nil, 2, 4],
    ]
    test_board(before, after, :right)
  end

  it "makes the example up move" do
    before = [
      [2,	2, nil, 2],
      [4, 2, 4, 4],
      [nil, nil, nil, nil],
      [nil, nil, nil, nil]
    ]
    after = [
      [2,	4, 4, 2],
      [4, nil, nil, 4],
      [nil, nil, nil, nil],
      [nil, nil, nil, nil]
    ]
    test_board(before, after, :up)
  end
  
  it "makes the example down move" do
    before = [
      [2,	2, nil, 2],
      [4, 2, 4, 4],
      [nil, nil, nil, nil],
      [nil, nil, nil, nil]
    ]
    after = [
      [nil, nil, nil, nil],
      [nil, nil, nil, nil],
      [2,	nil, nil, 2],
      [4, 4, 4, 4],
    ]
    test_board(before, after, :down)
  end
  
  describe "#print_board" do
    it "prints the board to standard output" do
      expect(subject).to receive(:print).at_least(:once)
      expect(subject).to receive(:puts).at_least(:once)
      subject.print_board
    end
  end
  
  describe "#insert_random_tile" do
    let!(:prior_tiles) { subject.cells.map{|cell| cell.tile}.compact }
    let(:result) { subject.insert_random_tile }
    
    it "creates a new tile" do
      result
      tiles = subject.cells.map{|cell| cell.tile}.compact
      expect(tiles.size).to eq(prior_tiles.size + 1)
    end
  end
  
  describe "#win?" do
    let(:result) { subject.win? }
    context "when a cell wins" do
      before { allow(subject.cells.sample).to receive(:win?).and_return(true) }
      it "is true" do
        expect(result).to eq(true)
      end
    end
    
    context "when no cell wins" do
      before do
        subject.cells.each do |cell|
          allow(cell).to receive(:win?).and_return(false)
        end
      end
      
      it "is false" do
        expect(result).to eq(false)
      end
    end
  end
  
  describe "#move_possible?" do
    let(:result) { subject.move_possible? }
    context "when any direction has a move possible" do
      before do
        allow(subject.directions[:up]).to receive(:move_possible?).and_return(true)
      end
      
      it "is true" do
        expect(result).to eq(true)
      end
    end
    
    context "when no direction has a move possible" do
      before do
        subject.directions.values.each do |direction|
          allow(direction).to receive(:move_possible?).and_return(false)
        end
      end

      it "is false" do
        expect(result).to eq(false)
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