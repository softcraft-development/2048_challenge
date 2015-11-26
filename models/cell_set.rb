require "cell"

class CellSet
  attr_reader :cells
  def initialize(cells)
    @cells = cells
  end
  
  def reverse
    CellSet.new(self.cells.reverse)
  end
end