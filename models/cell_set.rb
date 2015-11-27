require "cell"

# Cell sets always move the tiles "forward" (ie: towards the start of the array).
# This allows us to perform the same actions on the component cells regardless of the 
# direction we
# If you wanted to get crazy, you could define a cell set with any arbitrary collection of cells.
# Diagonal cell sets on an odd-numbered-sized grid might be interesting.
class CellSet
  attr_reader :cells
  def initialize(cells)
    @cells = cells
  end
  
  def move
    prior_cell = nil
    # get the existing tiles...
    tiles = @cells.map { |cell| cell.tile}.compact
    new_tiles = []
    begin
      # ...combine it with the next available tile, if possible...
      tile = tiles.shift
      new_tiles << tile
      if tiles.first && tiles.first.value == tile.value
        tile.value += tiles.first.value
        tiles.shift
      end
    end while(tiles.any?)
    # ...then assign the tiles to the forwardmost cells.
    # This slides and compacts the entire set of tiles in the cell set
    @cells.each do |cell|
      cell.tile = new_tiles.shift
    end
  end
  
  def move_possible?
    # If there's a tile that can be moved into a cell in this set,
    # then the cell set could be moved in its direction.
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