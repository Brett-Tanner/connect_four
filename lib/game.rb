class Game

  EMPTY_SLOT = " ○ "
  WHITE_PIECE = " ⚪ "
  BLACK_PIECE = " ⚫ "

  def initialize
    @board = Array.new(4) {Array.new(4, EMPTY_SLOT)}
    @turn_count = 0
  end
  
  def play_game
    print_board()
    # players take turns
    # check if game is over
    # declare winner
    # ask if they wanna play again
  end

  private

  def print_board
    @board.each {|row| puts row.join}
  end
end

# test = Game.new
# test.play_game