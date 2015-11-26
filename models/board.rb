require "row"

class Board
  ROW_COUNT = 4
  CELL_COUNT = ROW_COUNT * Row::CELL_COUNT
  INITIAL_CELL_COUNT = 2
  
  def initialize()
    @rows = ROW_COUNT.times.map{|counter| Row.new }
    @all_cells = []
    @rows.each do |row|
      @all_cells.concat(row.cells)
    end
  end
  
  def empty_cells
    @all_cells.select {|cell| cell.empty?}
  end
  
  def initialize_board
    empty_cells.sample(INITIAL_CELL_COUNT).each do |cell|
      cell.generate_tile
    end
  end

  def cell(cell_number)
    row = @rows[cell_number / ROW_COUNT]
    cell = row.cell(cell_number % ROW_COUNT)
    cell
  end
end