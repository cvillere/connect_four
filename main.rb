# frozen_string_literal: true

#functions to determine game status
module GameChecks

  WINNING_COMBOS = [[0, 7, 14, 21], [7, 14, 21, 28], [14, 21, 28, 35],
                    [1, 8, 15, 22], [8, 15, 22, 29], [15, 22, 29, 36],
                    [2, 9, 16, 23], [9, 16, 23, 30], [16, 23, 30, 37],
                    [3, 10, 17, 24], [10, 17, 24, 31], [17, 24, 31, 38],
                    [4, 11, 18, 25], [11, 18, 25, 32], [18, 25, 32, 39],
                    [5, 12, 19, 26], [12, 19, 26, 33], [19, 26, 33, 40], 
                    [6, 13, 20, 27], [13, 20, 27, 34], [20, 27, 34, 41], 
                    [0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6], 
                    [7, 8, 9, 10], [8, 9, 10, 11], [9, 10, 11, 12], [10, 11, 12, 13],
                    [14, 15, 16, 17], [15, 16, 17, 18], [16, 17, 18, 19], [17, 18, 19, 20],
                    [21, 22, 23, 24], [22, 23, 24, 25], [23, 24, 25, 26], [24, 25, 26, 27],
                    [28, 29, 30, 31], [29, 30, 31, 32], [30, 31, 32, 33], [31, 32, 33, 34],
                    [35, 36, 37, 38], [36, 37, 38, 39], [37, 38, 39, 40], [38, 39, 40, 41],
                    [0, 8, 16, 24], [8, 16, 24, 32], [16, 24, 32, 40], [7, 15, 23, 31], 
                    [15, 23, 31, 39], [14, 22, 30, 38], [1, 9, 17, 25], [9, 17, 25, 33],
                    [17, 25, 33, 41], [2, 10, 18, 26], [10, 18, 26, 34], [3, 11, 19, 27],
                    [3, 9, 15, 21], [4, 10, 16, 22], [10, 16, 22, 28], [5, 11, 17, 23],
                    [11, 17, 23, 28], [17, 23, 29, 35], [6, 12, 18, 24], [12, 18, 24, 30],
                    [18, 24, 30, 36], [13, 19, 25, 31], [19, 25, 31, 37], [20, 26, 32, 38]]
                  
  def check_winner?(player, board)
    WINNING_COMBOS.any? do |combo|
      [board[combo[0]], board[combo[1]], board[combo[2]], board[combo[3]]].uniq.length == 1
    end
  end

  def empty_spaces?(board)
    board.each do |item|
      return true if item.class == Integer
    end
    false
  end


end

# module for showing the game instructions
module DisplayInstructions

  def game_instructions
    puts 'Select a space for your move. The space at the lowest unoccupied space
    for that row. You cannot have a floating symbol move. The first player to 
    connect four of their moves either vertically, horizontally, or diagonally
    wins!'
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
end

# Player object for the connect four game
class Player

  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

end

# Board for the connect four game
class GameBoard

  include DisplayInstructions
  include GameChecks

  attr_accessor :board, :player_one, :player_two, :current_player
  
  def initialize
    @board = (1..42).to_a
    @player_one = player_one
    @player_two = player_two
    @current_player = nil
  end

  def show_board
    puts <<-HEREDOC

    #{@board[0]}   #{@board[1]}   #{@board[2]}   #{@board[3]}   #{@board[4]}   #{@board[5]}   #{@board[6]} 
    #{@board[7]}   #{@board[8]}   #{@board[9]}  #{@board[10]}  #{@board[11]}  #{@board[12]}  #{@board[13]} 
    #{@board[14]}  #{@board[15]}  #{@board[16]}  #{@board[17]}  #{@board[18]}  #{@board[19]}  #{@board[20]} 
    #{@board[21]}  #{@board[22]}  #{@board[23]}  #{@board[24]}  #{@board[25]}  #{@board[26]}  #{@board[27]} 
    #{@board[28]}  #{@board[29]}  #{@board[30]}  #{@board[31]}  #{@board[32]}  #{@board[33]}  #{@board[34]} 
    #{@board[35]}  #{@board[36]}  #{@board[37]}  #{@board[38]}  #{@board[39]}  #{@board[40]}  #{@board[41]} 

    HEREDOC
  end

  def create_player(num)
    name = get_player_name(num)
    sym = get_player_sym(name)
    Player.new(name, sym)
  end

  def assign_players
    @player_one = create_player(1)
    @player_two = create_player(2)
    check_dup_sym
    # player_sym
  end

  def check_dup_sym
    if @player_one.symbol == @player_two.symbol
      puts "Looks like the same symbol was chosen! #{@player_two.name}, please choose again!"
      get_player_sym(@player_two.name)
    end
  end

  def turns
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  def attain_move
    show_board
    puts "#{@current_player.name}, on what number would you like to place your symbol?"
    move = gets.chomp
    attain_move if move !~ /[\d\d]{1,2}/
    move_int = move.to_i
    attain_move if move_int < 1 || move_int > 42
    move_int - 1
  end

  def player_move
    board_move = attain_move
    check_move = deter_leg_move(board_move)
    return board_move if check_move == true

    (try_again; player_move) if check_move == false
    # @board[board_move] = @current_player.symbol
  end

  # The functions don't talk to each other well 
  # #try_again needs to call something other than #attain_move, probably player_move
  # but you need to figure out what to do with turns

  def check_spot_avail(mov_pos)
    return false if @board[mov_pos].is_a?(String)
  end

  def check_legality(mov_pos)
    empty_array = []
    until mov_pos >= 35
      mov_pos += 7
      empty_array.push(@board[mov_pos])
    end
    empty_array
  end

  def check_spaces(column_arr)
    return if column_arr.nil?

    if column_arr[0...-1].any? { |x| x.is_a?(Integer) }
      false
    else
      true
    end
  end

  def deter_leg_move(mov_pos)
    check_spot_avail(mov_pos) == false
    legal_move = check_legality(mov_pos)
    check_spaces(legal_move)
    # puts "check_spaces(legal_move) #{check_spaces(legal_move)}"
    # puts "this is mov pos #{mov_pos}"
  end

  def try_again
    puts "Your move isn't legal! Try again!"
  end

  def play_game
    assign_players
    turns
    game_winner = check_winner?(@current_player, @board)
    cats_game = empty_spaces?(@board)
    until game_winner == true || cats_game == false
      @board[player_move] = @current_player.symbol
      game_winner = check_winner?(@current_player, @board)
      cats_game = empty_spaces?(@board)
      puts "#{@current_player.name} you have won the game!" if game_winner == true
      puts "It's a cat's game" if cats_game == false
      turns
    end
    new_game
  end

  def new_game
    puts 'Would you like to play another game? 1 for yes.'
    game_reply = gets.chomp
    return if game_reply != "1"
    GameBoard.new.play_game
  end

end



my_board = GameBoard.new.play_game



