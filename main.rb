# frozen_string_literal: true

# require 'pry'

class GameBoard

  attr_accessor :board

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
end

#flow
my_board = GameBoard.new()
board_structure = my_board.make_board
board_display = my_board.display_board
board_display

module GameRules

  def show_game_rules
    puts 'Select a row and column to put your letter (X) for player 1 and 
    (O) for player 2. The space must either be the lowest row or on top of
    existing moves at given spaces. New selections will not replace prior
    selections'
  end

end