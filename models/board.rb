class Board
  ROW_COUNT = 4
  
  def initialize()
    @rows = ROW_COUNT.times.map{|counter| Row.new }
  end
end