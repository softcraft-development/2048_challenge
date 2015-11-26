class Row
  def initialize
    @tiles = 4.times {|counter| Tile.new }
  end
end