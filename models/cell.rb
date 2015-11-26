class Cell
  PROBABILITY_OF_LOW_GENERATED_CELL = 0.9
  HIGH_GENERATED_CELL_VALUE = 4
  LOW_GENERATED_CELL_VALUE = 2
  
  attr_reader :value
  def initialize
    @value = nil
  end
  
  def generate_value
    raise "Cannot generate a new value in a nonempty cell" unless empty?
    @value = rand() > PROBABILITY_OF_LOW_GENERATED_CELL ? HIGH_GENERATED_CELL_VALUE : LOW_GENERATED_CELL_VALUE
  end
  
  def empty?
    @value == nil
  end
  
  def merge(merging_value)
    raise "Incompatible value: #{merging_value}" if @value != nil && @value != merging_value
    @value += merging_value
  end
  
  def merge_into(destination_cell)
    destination_cell.value
    
  end
end