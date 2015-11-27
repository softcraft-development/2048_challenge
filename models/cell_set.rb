require "cell"

class CellSet
  attr_reader :cells
  def initialize(cells)
    @cells = cells
  end
  
  def move
    prior_cell = nil
    @cells.each_with_index do |cell, index|
      remaining_cells = @cells[(index + 1)..-1]
      next_nonempty_cell = remaining_cells.find { |cell| !cell.empty?}
      if next_nonempty_cell && cell.mergeable_with?(next_nonempty_cell.tile)
        cell.merge(next_nonempty_cell.tile)
        next_nonempty_cell.tile = nil
      end
    end
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