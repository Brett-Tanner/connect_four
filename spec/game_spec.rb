require_relative "../lib/game.rb"

describe "Game" do
  subject(:game) {Game.new}
  let(:board) {game.instance_variable_get(:@board)}

  context "when initialized" do
    it "creates a 4x4 board" do
      num_of_rows = board.length
      row_length = board[0].length
      expect(num_of_rows).to eql(4)
      expect(row_length).to eql(4)
    end

    it "all spaces = ○" do
      all_empty = board.all? {|row| row.all?(" ○ ")}
      expect(all_empty).to be true
    end
  end

  describe "#take_turn" do
    
  end

  describe "#play_game" do
    it "starts by printing the board" do
      expect(game).to receive(:print_board).once
      game.play_game
    end
  end
end