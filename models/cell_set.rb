require "cell"

class CellSet
  attr_reader :cells
  def initialize(cells)
    @cells = cells
  end
  
  def move_possible?
    prior_cell = nil
    @cells.any? do |cell|
      return true if cell.empty?
      
      if prior_cell
        mergeable = prior_cell.mergeable_with?(cell.tile)
      else
        mergeable = false
      end
      prior_cell = cell
      mergeable
    end
  end
  
  def reverse
    CellSet.new(self.cells.reverse)
  end
end