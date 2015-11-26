require "row"

class Board
  ROW_COUNT = 4
  TILE_COUNT = ROW_COUNT * Row::TILE_COUNT
  INITIAL_TILE_COUNT = 2
  
  def initialize()
    @rows = ROW_COUNT.times.map{|counter| Row.new }
  end
  
  def initialize_board
    INITIAL_TILE_COUNT.times do |initial_tile|
      tile_number = rand(TILE_COUNT)
      begin 
        t = tile(tile_number)
      end until (t.empty?)
      
      t.generate_value
    end
  end

  def tile(tile_number)
    row = @rows[tile_number / ROW_COUNT]
    tile = row.tile(tile_number % ROW_COUNT)
    tile
  end
end