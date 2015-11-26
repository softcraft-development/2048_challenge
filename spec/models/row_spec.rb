require "spec_helper"

describe Row do
  subject { Row.new }
  
  describe "#cell" do
    let(:result) { subject.cell(cell_number)}
    
    context "when the cell number corresponds to a cell" do
      let(:cell_number) { rand(Row::CELL_COUNT)}
      
      it "returns the cell for the number" do
        target_cell = subject.instance_variable_get(:@cells)[cell_number]
        
        expect(result).to be(target_cell)
      end
    end
  end
end