# frozen_string_literal: true

# require 'pry'

class GameBoard

  attr_accessor :board

  def initialize(board = [])
    @board = board
  end

  def make_board
    6.times do
      @board.push(['[ ]', '[ ]', '[ ]', '[ ]', '[ ]', '[ ]', '[ ]'])
    end
  end
  
end