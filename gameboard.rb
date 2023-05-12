# frozen_string_literal: true

# Board for the connect four game
class GameBoard

  include DisplayInstructions
  include GameChecks

  attr_accessor :board, :player_one, :player_two, :current_player
  
  def initialize
    @board = Array.new(6) { Array.new(7, "\u2666") }
    @player_one = player_one
    @player_two = player_two
    @current_player = nil
  end

  def show_board
    @board.each do |sub_arr|
      puts sub_arr.join(' ')
    end
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
    puts "#{@current_player.name}, which row would you like to place your symbol"
    row = gets.chomp.to_i
    (try_again; attain_move) if row < 1 || row > 6
    puts "#{@current_player.name}, which column would you like to place your symbol"
    col = gets.chomp.to_i
    (try_again; attain_move) if col < 1 || col > 7
    col -= 1
    row -= 1
    move_int = [row, col]
  end

  def player_move
    board_move = attain_move
    check_move = deter_leg_move(board_move)
    return board_move if check_move == true

    (try_again; player_move) if check_move == false
  end

  def deter_leg_move(mov_pos)
    single_col = check_legality(mov_pos, @board)
    vert_legal = check_spaces(single_col)
    if check_spot_avail(mov_pos, @board) == true && vert_legal == true
      true
    else
      false
    end
  end

  def start_game
    game_instructions
    assign_players
    turns
  end

  def play_game
    start_game
    game_winner = check_winner?(@board, @current_player.symbol)
    cats_game = empty_spaces?(@board)
    until game_winner == true || cats_game == false
      move = player_move
      @board[move[0]][move[1]] = @current_player.symbol
      game_winner = check_winner?(@board, @current_player.symbol)
      cats_game = empty_spaces?(@board)
      puts "#{@current_player.name}, you have won the game!" if game_winner == true
      puts "It's a cat's game" if cats_game == false
      turns
    end
    show_board
    new_game
  end

  def new_game
    puts 'Would you like to play another game? 1 for yes. 2 for no.'
    game_reply = gets.chomp
    return if game_reply != "1"
    GameBoard.new.play_game
  end

end