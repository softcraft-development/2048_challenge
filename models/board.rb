require "cell"
require "direction"

class Board
  ROW_COUNT = 4
  COLUMN_COUNT = 4
  CELL_COUNT = ROW_COUNT * COLUMN_COUNT
  INITIAL_CELL_COUNT = 2
  
  attr_reader :cells
  def initialize()
    @cells = CELL_COUNT.times.map { Cell.new }
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