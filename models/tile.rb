class Tile
  PROBABILITY_OF_LOW_GENERATED_VALUE = 0.9
  HIGH_GENERATED_VALUE = 4
  LOW_GENERATED_VALUE = 2
  
  attr_accessor :value
  def initialize(initial_value)
    @value = initial_value
  end
  
  class << self
    def generate
      value = rand() > PROBABILITY_OF_LOW_GENERATED_VALUE ? HIGH_GENERATED_VALUE : LOW_GENERATED_VALUE
      Tile.new(value)
    end
  end
end