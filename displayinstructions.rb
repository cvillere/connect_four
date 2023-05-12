# frozen_string_literal: true

# module for showing the game instructions
module DisplayInstructions

  def game_instructions
    puts <<-HEREDOC

    CONNECT FOUR:
    Select a space for your move. The space must be at the lowest unoccupied space
    for that column. You cannot have a floating symbol move. The first player to 
    connect four of their moves either vertically, horizontally, or diagonally
    wins!
    
    HEREDOC

  end

  def get_player_name(player_num)
    puts "what is player #{player_num}'s name"
    player_name = gets.chomp
  end

  def get_player_sym(player_name)
    puts "#{player_name}, what letter would you like to use?"
    player_sym = gets.chomp.upcase
    player_sym_check(player_name, player_sym)
    player_sym
  end

  def player_sym_check(player_name, player_sym)
    get_player_sym(player_name) if player_sym.length > 1
    get_player_sym(player_name) if player_sym.between?('A', 'Z') == false
  end

  def try_again
    puts "Your move isn't legal! Try again!"
  end
end