class Board
  ROW_COUNT = 4
  TILE_COUNT = ROW_COUNT * Row::TILE_COUNT
  
  def initialize()
    @rows = ROW_COUNT.times.map{|counter| Row.new }
  end
end