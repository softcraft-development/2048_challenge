require "cell"
require "direction"

class Board
  ROW_COUNT = 4
  COLUMN_COUNT = 4
  CELL_COUNT = ROW_COUNT * COLUMN_COUNT
  INITIAL_CELL_COUNT = 2
  
  attr_reader :cells
  attr_reader :directions
  def initialize()
    @cells = CELL_COUNT.times.map { Cell.new }
    
    right_cells = COLUMN_COUNT.times.map { [] }
    down_cells = ROW_COUNT.times.map { [] }
    
    @cells.each_with_index do |cell, index|
      column = index % COLUMN_COUNT 
      # The parenthesis here are solely to work around a weird
      # syntax highlighting bug in Textmate
      row = (index / ROW_COUNT)
      
      right_cells[row] << cell
      down_cells[column] << cell
    end
    
    right_cell_sets = right_cells.map {|cells| CellSet.new(cells)}
    down_cell_sets = down_cells.map {|cells| CellSet.new(cells)}
    
    @directions = {}
    @directions[:right] = Direction.new(right_cell_sets)
    @directions[:left] = @directions[:right].reverse
    @directions[:down] = Direction.new(down_cell_sets)
    @directions[:up] = @directions[:down].reverse
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