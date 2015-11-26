class Tile
  PROBABILITY_OF_LOW_GENERATED_TILE = 0.9
  HIGH_GENERATED_TILE_VALUE = 4
  LOW_GENERATED_TILE_VALUE = 2
  
  def initialize
    @value = nil
  end
  
  def generate_value
    raise "Cannot generate a new value in a nonempty tile" unless empty?
    @value = rand() > PROBABILITY_OF_LOW_GENERATED_TILE ? HIGH_GENERATED_TILE_VALUE : LOW_GENERATED_TILE_VALUE
  end
  
  def empty?
    @value == nil
  end
end