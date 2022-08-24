class Game

  attr_accessor :board, :turn_count

  EMPTY = " ○ "
  WHITE = "⚪ "
  BLACK = "⚫ "

  def initialize
    @board = Array.new(4) {Array.new(4, EMPTY)}
    @turn_count = 0
  end
  
  def play_game
    print_board()
    puts "#{BLACK} goes first"
    winner = loop do
      play_turn(BLACK)
      break BLACK if game_over?()
      play_turn(WHITE)
      break WHITE if game_over?()
      break "draw" if @turn_count >=16
    end
    puts "Oh no, it's a draw! No one wins." if winner == "draw"
    puts "Congratulations #{winner}!" if winner == BLACK || winner == WHITE
    print_board()
    reset_game()
  end

  def play_turn(player)
    coordinates = get_coordinates(player)
    row = coordinates[0] - 1
    col = coordinates[1] - 1
    return play_turn(player) unless valid_move?(row, col)
    @turn_count += 1
    @board[row][col] = player
    print_board()
  end

  def get_coordinates(player)
    puts "#{player}, enter coordinates like 'row, col'"
    input = gets.chomp.split(", ")
    if input.length != 2
      puts "**You entered the wrong number of digits!**"
      return get_coordinates(player)
    end
    input.map {|char| char.to_i}
  end

  def valid_move?(row, col)
    return false if !inbounds?(row, col) || !unoccupied?(row, col)
    true
  end

  def game_over?
    return true if row_win?() || column_win?() || diagonal_win?()
    false
  end

  private

  def print_board
    @board.each {|row| puts row.join}
  end

  def return_board()
    @board
  end

  def inbounds?(row, col)
    return true if row >= 0 && row <= 3 && col >= 0 && col <= 3
    puts "**Coordinates must be between 1 and 4**"
    false
  end

  def unoccupied?(row, col)
    return true if return_board()[row][col] == EMPTY
    puts "**That space is occupied!**"
    false
  end

  def row_win?
    @board.any? {|row| row.all?(BLACK) || row.all?(WHITE)}
  end

  def column_win?
    0..4.times do |i|
      col = [@board[0][i], @board[1][i], @board[2][i], @board[3][i]]
      return true if col.all?(BLACK) || col.all?(WHITE)
    end
    false
  end

  def diagonal_win?
    l_diagonal = [@board[0][3], @board[1][2], @board[2][1], @board[3][0]]
    r_diagonal = [@board[0][0], @board[1][1], @board[2][2], @board[3][3]]
    l_diagonal.all?(BLACK) || l_diagonal.all?(WHITE) || r_diagonal.all?(BLACK) || r_diagonal.all?(WHITE)
  end

  def reset_game
    puts "Do you want to play again?"
    ans = gets.chomp.downcase
    case ans
    when "y"
      @board = Array.new(4) {Array.new(4, EMPTY)}
      @turn_count = 0
      play_game()
    when "n"
      exit(0)
    else
      puts "**You must respond with 'y' or 'n'**"
      return reset_game()
    end
  end
end

test = Game.new
test.play_game