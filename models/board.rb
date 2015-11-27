require "cell"
require "direction"

class Board
  # These are fully customizable; change them to create a different sized grid
  ROW_COUNT = 4
  COLUMN_COUNT = 4
  CELL_COUNT = ROW_COUNT * COLUMN_COUNT
  INITIAL_CELL_COUNT = 2
  
  attr_reader :cells
  attr_reader :directions
  def initialize()
    # The cells are kept in a single flat array
    @cells = CELL_COUNT.times.map { Cell.new }
    
    # Then we assign them to "cell sets", which are rows of cells
    # ordered in a particular direction of movement. A "direction"
    # is a collection of these cell sets, one for each row/column
    # of the grid.
    left_cells = COLUMN_COUNT.times.map { [] }
    up_cells = ROW_COUNT.times.map { [] }
    
    @cells.each_with_index do |cell, index|
      column = index % COLUMN_COUNT 
      # The parenthesis here are solely to work around a weird
      # syntax highlighting bug in Textmate
      row = (index / ROW_COUNT)
      
      left_cells[row] << cell
      up_cells[column] << cell
    end
    
    left_cell_sets = left_cells.map {|cells| CellSet.new(cells)}
    up_cell_sets = up_cells.map {|cells| CellSet.new(cells)}
    
    # The "right" and "down" directions are just the same cell sets but
    # with the opposite cell orders. This allows us to have single unified
    # algorithms for the move/move_possible actions that don't depend
    # on the direction of the movement on the virtualized "grid".
    @directions = {}
    @directions[:left] = Direction.new(left_cell_sets)
    @directions[:right] = @directions[:left].reverse
    @directions[:up] = Direction.new(up_cell_sets)
    @directions[:down] = @directions[:up].reverse
  end
  
  def print_board
    @directions[:left].cell_sets.map do |cell_set|
      cell_set.cells.map do |cell|
        print "[#{(cell.value.to_s).rjust(4)}]"
      end
      puts ""
    end
  end
  
  def insert_random_tile
    empty_cells.sample.generate_tile
  end
  
  def win?
    @cells.any? {|cell| cell.win? }
  end
  
  def move_possible?
    [:left, :up, :right, :down].any? do |direction|
      @directions[direction].move_possible?
    end
  end
  
  def empty_cells
    @cells.select {|cell| cell.empty?}
  end
  
  def initialize_board
    empty_cells.sample(INITIAL_CELL_COUNT).each do |cell|
      cell.generate_tile
    end
  end
end