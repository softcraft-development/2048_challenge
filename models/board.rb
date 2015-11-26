require "row"

class Board
  ROW_COUNT = 4
  TILE_COUNT = ROW_COUNT * Row::TILE_COUNT
  
  def initialize()
    @rows = ROW_COUNT.times.map{|counter| Row.new }
  end
  
  def tile(tile_number)
    row = @rows[tile_number / ROW_COUNT]
    tile = row.tile(tile_number % ROW_COUNT)
    tile
  end
end