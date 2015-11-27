# run with: bundle exec ruby aria_2048.rb
require_relative "initialization"

# Reading arrow keys from STDIN is surprisingly difficult for Ruby
# The read_char code is borrowed from https://gist.github.com/acook/4190379
require 'io/console'
def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

puts "The Game of 2048. Arrow keys move the board; Q or Esc to exit."

board = Board.new
board.initialize_board
board.print_board

begin
  puts "------------------------"
  
  c = read_char
  case c
  when "\e[A"
    direction = :up
  when "\e[B"
	  direction = :down
	when "\e[C"
	  direction = :right
	when "\e[D"
	  direction = :left
  when "\e"
    exit
  when "q"
    exit
  end
  
  if direction
    dir = board.directions[direction]
    if dir.move_possible?
      puts "Move [#{direction}]"
      dir.move
      board.insert_random_tile
    else
      puts "Move [#{direction}] not allowed."
    end
  end
  board.print_board
end while (!board.win? && board.move_possible? )

if board.win?
  puts "You win with #{Cell::GOAL}!"
else
  puts "You lose!"
end