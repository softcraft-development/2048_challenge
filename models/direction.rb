require "cell_set"

class Direction
  def initialize(cell_sets)
    @cell_sets = cell_sets
  end
  
  def reverse
    cell_sets = @cell_sets.map do |cell_set|
      cell_set.reverse
    end
    Direction.new(cell_sets)
  end
end