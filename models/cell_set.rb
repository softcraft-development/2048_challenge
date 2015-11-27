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
      remaining_cells.each do |next_cell|
        unless next_cell.empty?
          if cell.mergeable_with?(next_cell.tile)
            cell.merge(next_cell.tile)
            next_cell.tile = nil
            break
          end
        end
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