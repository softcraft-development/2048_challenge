require "cell"

class CellSet
  attr_reader :cells
  def initialize(cells)
    @cells = cells
  end
end