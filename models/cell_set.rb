require "cell"

class CellSet
  attr_reader :cells
  def initialize(cells)
    @cells = cells
  end
  
  def move
    prior_cell = nil
    tiles = @cells.map { |cell| cell.tile}.compact
    new_tiles = []
    begin
      tile = tiles.shift
      new_tiles << tile
      if tiles.first && tiles.first.value == tile.value
        tile.value += tiles.first.value
        tiles.shift
      end
    end while(tiles.any?)
    @cells.each do |cell|
      cell.tile = new_tiles.shift
    end
  end
  
  def move_possible?
    prior_cell = nil
    @cells.any? do |cell|
      movable = false
      if cell.empty? 
        movable = false
      elsif prior_cell
        movable = prior_cell.mergeable_with?(cell.tile) 
      else
        movable = false
      end
      prior_cell = cell
      movable
    end
  end
  
  def reverse
    CellSet.new(self.cells.reverse)
  end
end