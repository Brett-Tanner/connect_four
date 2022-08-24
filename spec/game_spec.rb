require_relative "../lib/game.rb"

describe "Game" do
  subject(:game) {Game.new}
  let(:board) {game.instance_variable_get(:@board)}

  before do
    allow(game).to receive(:puts)
  end

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

  describe "#get_coordinates" do
    let(:player) {("⚫")}
    let(:coordinates) {game.get_coordinates(player)}

    context "when given valid coordinates" do

      before do
        allow(game).to receive(:gets).and_return("1, 4")
      end

      it "returns an array" do
        expect(coordinates).to be_an_instance_of Array
      end
  
      it "of two values" do
        length = coordinates.length
        expect(length).to eql(2)
      end
  
      it "both integers" do
        row = coordinates[0]
        col = coordinates[1]
        expect(row).to be_an_instance_of Integer
        expect(col).to be_an_instance_of Integer
      end
    end

    context "when input is too long" do

      before do
        allow(game).to receive(:gets).and_return("3, 5, 7, 10", "2, 3")
      end

      it "displays error" do
        error = "**You entered too many numbers**"
        expect(game).to receive(:puts).with(error).once
        game.get_coordinates(player)
      end

      it "calls self" do
        expect(game).to receive(:get_coordinates).once
        game.get_coordinates(player)
      end

      it "returns the valid coordinates" do
        valid_coord = [2, 3]
        return_val = game.get_coordinates(player)
        expect(return_val).to eql(valid_coord)
      end
    end
  end
  
  describe "#valid_move?" do
    context "when coordinates are out of bounds" do
      let(:row) {4}
      let(:col) {-1}

      it "displays a helpful error" do
        error = "**Coordinates must be between 1 and 4**"
        expect(game).to receive(:puts).with(error).once
        game.valid_move?(row, col)
      end

      it "returns false" do
        valid = game.valid_move?(row, col)
        expect(valid).to be false
      end
    end

    context "when space is occupied" do
      let(:row) {3}
      let(:col) {3}
      
      before do
        allow(game).to receive(:return_board).and_return(Array.new(4) {Array.new(4, " ⚪ ")})
      end

      it "displays a helpful error" do
        error = "**That space is occupied!**"
        expect(game).to receive(:puts).with(error).once
        game.valid_move?(row, col)
      end

      it "returns false" do
        valid = game.valid_move?(row, col)
        expect(valid).to be false
      end
    end

    context "when move is valid" do
      let(:row) {0}
      let(:col) {0}

      it "returns true" do
        valid = game.valid_move?(row, col)
        expect(valid).to be true
      end
    end
  end

  describe "#play_turn" do

    context "when player gives valid coordinates" do

      before do
        allow(game).to receive(:gets).and_return("1, 1")
      end
      
      it "changes the space at the coordinates" do
        expect {game.play_turn(" ⚪ ")}.to change {game.board[0][0]}.from(" ○ ").to(" ⚪ ")
      end
    end

    context "when player gives invalid coordinates" do
      before do
        allow(game).to receive(:gets).and_return("5, 5", "3, 3")
      end
      
      it "doesn't change the space at the coordinates" do
        expect {game.play_turn(" ⚪ ")}.not_to change {game.board[0][0]}
      end
    end

    context "when player gives occupied coordinates" do
      before do
        allow(game).to receive(:gets).and_return("1, 1", "2, 2")
      end
      
      it "doesn't change the space at the coordinates" do
        game.board[0][0] = " ⚪ "
        expect {game.play_turn(" ⚪ ")}.not_to change {game.board[0][0]}
      end
    end
  end

  describe "#game_over" do
    
  end

  describe "#play_game" do
    it "starts by printing the board" do
      expect(game).to receive(:print_board).once
      game.play_game
    end
  end
end