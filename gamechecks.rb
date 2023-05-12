# frozen_string_literal: true

# functions to determine game status
module GameChecks

  def check_diag?(board, symbol)
    winning_arr = []
    ter = 0
    board.each_with_index do |n, n_index|
      n.each_with_index do |_m, m_index|
        return if n_index == 3

        while ter < 4 && m_index < 4
          winning_arr.push(board[n_index + ter][m_index + ter])
          ter += 1
        end
        return true if winning_arr.length >= 1 && winning_arr.slice(-4..-1).all?(symbol)

        ter = 0
        winning_arr = []
      end
    end
  end

  def check_vert?(board, symbol)
    count = 0
    vert_arr = []
    while count < 7
      board.each do |item|
        vert_arr.push(item[count])
        return true if vert_arr.length >= 4 && vert_arr.slice(-4..-1).all?(symbol)
      end
      count += 1
      vert_arr = []
    end
  end

  def check_horiz?(board, symbol)
    horiz_arr = []
    board.each_with_index do |a, a_index|
      a.each do |b|
        horiz_arr.push(b)
        return true if horiz_arr.length >= 4 && horiz_arr.slice(-4..-1).all?(symbol)
      end
      horiz_arr = []
    end
    false
  end

  def check_winner?(board, sym)
    if check_diag?(board, sym) == true || check_diag?(board.reverse, sym) == true
      return true
    end

    puts "check_vert?(board, sym) #{check_vert?(board, sym)}"
    puts "check_horiz?(board, sym) #{check_horiz?(board, sym)}"
    if check_vert?(board, sym) == true || check_horiz?(board, sym) == true
      true
    end
  end

  def empty_spaces?(board)
    board.each do |item|
      item.each do |diamond|
        return true if diamond == "\u2666"
      end
    end
    false
  end

  def check_spot_avail(mov_pos, board)
    if board[mov_pos[0]][mov_pos[1]] == "\u2666"
      return true
    else
      return false
    end
  end

  def check_legality(mov_pos, board)
    empty_array = []
    board.each_with_index do |r, r_index|
      empty_array.push(r[mov_pos[1]])
    end
    empty_array.slice(mov_pos[0]..-1)
  end

  def check_spaces(column_arr)
    puts "column_arr #{column_arr}"
    return true if column_arr.length.zero? || column_arr.length == 1

    if column_arr[1..].any?("\u2666")
      false
    else
      true
    end
  end
end