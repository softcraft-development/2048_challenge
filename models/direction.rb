require "cell_set"

class Direction
  attr_reader :cell_sets
  def initialize(cell_sets)
    @cell_sets = cell_sets
  end
  
  def move
    @cell_sets.each do |cell_set|
      cell_set.move
    end
  end
  
  def move_possible?
    @cell_sets.any? { |cell_set| cell_set.move_possible? }
  end
  
  def reverse
    cell_sets = @cell_sets.map do |cell_set|
      cell_set.reverse
    end
    Direction.new(cell_sets)
  end
end