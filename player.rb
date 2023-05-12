# frozen_string_literal: true

# Player object for the connect four game
class Player

  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

end