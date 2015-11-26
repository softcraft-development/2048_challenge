require "tile"

class Cell
  attr_reader :tile
  def initialize
    @tile = nil
  end
  
  def generate_tile
    raise "Cannot generate a new tile in a nonempty cell" unless empty?
    @tile = Tile.generate
  end
  
  def empty?
    @tile == nil
  end
  
  def merge(merging_value)
    raise "Incompatible value: #{merging_value}" if @tile != nil && @tile != merging_value
    @tile += merging_value
  end
  
  def merge_into(destination_cell)
    destination_cell.value
    
  end
end