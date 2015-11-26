require "spec_helper"

describe Direction do
  let(:cell_sets) do
    cell_count = rand(4) + 2
    
    (rand(4) + 2).times.map do
      cells = cell_count.times.map do 
        Cell.new
      end
      CellSet.new(cells)
    end
  end  
  
  subject { Direction.new(cell_sets) }
end