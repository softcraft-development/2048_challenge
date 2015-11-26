require "spec_helper"

describe CellSet do
  let(:cells) { (rand(10) + 2).times.map { Cell.new } }
  subject { CellSet.new(cells) }
end