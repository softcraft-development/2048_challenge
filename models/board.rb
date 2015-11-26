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
    
    @directions = {}
    @directions[:left] = Direction.new(left_cell_sets)
    @directions[:right] = @directions[:left].reverse
    @directions[:up] = Direction.new(up_cell_sets)
    @directions[:down] = @directions[:up].reverse
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