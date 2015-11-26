require "spec_helper"

describe Row do
  subject { Row.new }
  
  describe "#tile" do
    let(:result) { subject.tile(tile_number)}
    
    context "when the tile number corresponds to a tile" do
      let(:tile_number) { rand(Row::TILE_COUNT)}
      
      it "returns the tile for the number" do
        target_tile = subject.instance_variable_get(:@tiles)[tile_number]
        
        expect(result).to be(target_tile)
      end
    end
  end
end