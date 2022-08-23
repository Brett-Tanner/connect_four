class Game

  EMPTY = " ○ "
  WHITE = " ⚪ "
  BLACK = " ⚫ "

  def initialize
    @board = Array.new(4) {Array.new(4, EMPTY)}
    @turn_count = 0
  end
  
  def play_game
    print_board()
    puts "#{BLACK} goes first"
    # loop 
      # play_turn(BLACK)
      # break if game_over?
      # play_turn(WHITE)
      # break if game_over?
    # declare winner
    # ask if they wanna play again
  end

  def play_turn(player)
    coordinates = get_coordinates(player)
    row = coordinates[0] - 1
    col = coordinates[1] - 1
    # update board if unoccupied and in bounds
  end

  def get_coordinates(player)
    puts "#{player}, enter coordinates like 'row, col'"
    input = gets.chomp.split(", ")
    if input.length > 2
      puts "**You entered too many numbers**"
      return get_coordinates(player)
    end
    input.map {|char| char.to_i}
  end

  def valid_move?(row, col)
    
  end

  def game_over?
    
  end

  private

  def print_board
    @board.each {|row| puts row.join}
  end
end

# test = Game.new
# test.play_game