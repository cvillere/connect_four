# frozen_string_literal: true

# require 'pry'

class GameBoard

  attr_accessor :board

  include GameRules

  def initialize(board)
    @board = board
  end

  def make_board
    6.times do
      @board.push(['[ ]', '[ ]', '[ ]', '[ ]', '[ ]', '[ ]', '[ ]'])
    end
    @board
  end

  def display_board
    @board = @board.each do |x|
      puts x.join('')
    end
  end

  def get_p1move
    show_move_rules
    puts 'Where would you like to put your (X)? Enter row, then column'
    row = gets.to_i
    column = gets.to_i
    row -= 1
    column -= 1
    play = [row, column]
    # check to make sure move is valid
    # @board[play[0]][play[1]] = ' X '
  end

  def get_p2move
    show_move_rules
    puts 'Where would you like to put your (O)? Enter row, then column'
    row = gets.to_i
    column = gets.to_i
    row -= 1
    column -= 1
    play = [row, column]
    # check to make sure move is valid
    # @board[play[0]][play[1]] = ' O '
  end

end

#flow
my_board = GameBoard.new()
board_structure = my_board.make_board
board_display = my_board.display_board
board_display

#holds rules to show players at different points during the game
module GameRules

  def show_game_rules
    puts 'Select a row and column to put your letter (X) for player 1 and 
    (O) for player 2. The space chosen must either be the lowest row or on top of
    existing moves at given spaces. There CANNOT be a gap in rows between moves
    already made and a new move. New selections will not replace prior
    selections.'
  end

  def show_win_criteria
    puts 'A player wins when 4 of their letters are consecutively connected either
    vertically, horizontally, or diagonally'
  end

  def show_move_rules
    puts "1.Space chosen must be the lowest row or on top of existing moves, 
    without creating a gap in the rows.
    2. Space chosen must be available as new moves will not replace old moves."
  end
end

module ValidMoves

  def check_pos_open

  end

  def 

end
