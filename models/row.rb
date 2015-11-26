require "tile"

class Row
  TILE_COUNT = 4
  
  def initialize
    @tiles = TILE_COUNT.times {|counter| Tile.new }
  end
  
  def tile(tile_number)
    @tiles[tile_number]
  end
end