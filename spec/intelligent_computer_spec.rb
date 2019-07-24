require "./lib/intelligent_computer"

RSpec.describe IntelligentComputer do
  let(:board) { Board.new }
  let(:ship) { Ship.new("Boaty McBoatface", 3) }
  let(:coordinates) { ["A1", "A2", "A3"] }
  let(:smarty_pants) { IntelligentComputer.new(board) }

  before do
    board.place(ship, coordinates)
  end
  describe "#initialize" do
    it "takes in a board" do
      expect(smarty_pants.board).to be_instance_of Board
    end
  end
  describe "#find_coordinates" do
    context "when there are no hits on the board" do
      it "returns nil" do
        expect(smarty_pants.find_coordinates).to be nil
        board.cells["B1"].fire_upon
        expect(smarty_pants.find_coordinates).to be nil
        board.cells["A1"].fire_upon
        board.cells["A2"].fire_upon
        board.cells["A3"].fire_upon
        expect(smarty_pants.find_coordinates).to be nil
      end
    end
    context "when there are hits on the board" do
      it "returns coordinates" do
        board.cells["A1"].fire_upon
        expect(smarty_pants.find_coordinates).to be ["A2", "B1"]
        board.cells["B1"].fire_upon
        expect(smarty_pants.find_coordinates).to be ["A2"]
        board.cells["A2"].fire_upon
        expect(smarty_pants.find_coordinates).to be ["A3", "B2"]
      end
    end
  end
end
