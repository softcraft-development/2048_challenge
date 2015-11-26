require "row"

class Board
  ROW_COUNT = 4
  CELL_COUNT = ROW_COUNT * Row::CELL_COUNT
  INITIAL_CELL_COUNT = 2
  
  def initialize()
    @rows = ROW_COUNT.times.map{|counter| Row.new }
  end
  
  def initialize_board
    INITIAL_CELL_COUNT.times do |initial_cell|
      cell_number = rand(CELL_COUNT)
      begin 
        t = cell(cell_number)
      end until (t.empty?)
      
      t.generate_value
    end
  end

  def cell(cell_number)
    row = @rows[cell_number / ROW_COUNT]
    cell = row.cell(cell_number % ROW_COUNT)
    cell
  end
  
end