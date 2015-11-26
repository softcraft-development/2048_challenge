class Board
  def initialize()
    @rows = 4.times.map{|counter| Row.new }
  end
end