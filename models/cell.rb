require "tile"

class Cell
  attr_accessor :tile
  def initialize(tile = nil)
    @tile = tile
  end
  
  def merge(tile)
    if @tile == nil
      @tile = tile
    else
      raise "Cannot merge tiles with differing values" unless @tile.value == tile.value
      @tile.value += tile.value
    end
  end
  
  def mergeable_with?(tile)
    return true if empty?
    return true if self.tile.value == tile.value
    return false
  end
    
  def generate_tile
    raise "Cannot generate a new tile in a nonempty cell" unless empty?
    @tile = Tile.generate
  end
  
  def empty?
    @tile == nil
  end
end