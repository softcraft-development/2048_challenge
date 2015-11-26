require "cell"

class Row
  CELL_COUNT = 4
  
  attr_reader :cells
  def initialize
    @cells = CELL_COUNT.times.map {|counter| Cell.new }
  end
  
  def cell(cell_number)
    @cells[cell_number]
  end
end