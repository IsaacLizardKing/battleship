require "./lib/board"

RSpec.describe Board do
  let(:board) { Board.new }
  let(:ship_1) { Ship.new("Boaty McBoatface", 3) }
  let(:ship_2) { Ship.new("Titanic", 2) }
  let(:coordinates_1) { ["A1", "A2"] }
  let(:coordinates_2) { ["A1", "A3", "B4"] }
  let(:blank_board)
  {
    "  1 2 3 4 \n" +
    "A . . . . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . "
  }

  let(:ship_board)
  {
    "  1 2 3 4 \n" +
    "A S S . . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . "
  }

  let(:hit_board)
  {
    "  1 2 3 4 \n" +
    "A H . . . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . "
  }

  let(:miss_board)
  {
    "  1 2 3 4 \n" +
    "A H . . . \n" +
    "B M . . . \n" +
    "C . . . . \n" +
    "D . . . . "
  }

  let(:sunk_board)
  {
    "  1 2 3 4 \n" +
    "A X X . . \n" +
    "B M . . . \n" +
    "C . . . . \n" +
    "D . . . . "
  }

  let(:hit_board_ship)
  {
    "  1 2 3 4 \n" +
    "A H S . . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . "
  }

  let(:miss_board_ship)
  {
    "  1 2 3 4 \n" +
    "A H S . . \n" +
    "B M . . . \n" +
    "C . . . . \n" +
    "D . . . . "
  }

  describe "#initialize" do
    it "contains a hash of 16 cells" do
      expect(board.cells).to be_kind_of Hash
      expect(board.cells.count).to eq 16
      board.cells.values.all? { |cell| expect(cell).to be_instance_of Cell}
    end
  end

  describe "#place" do
    context "when coordinates are valid" do
      it "adds the ship to the cells" do
        board.place(ship_2, coordinates_1)
        expect(board.cells["A1"].ship).to eq ship_2
        expect(board.cells["A2"].ship).to eq ship_2
      end
    end
    context "when coordinates are invalid" do
      it "does not add the ship to the cells" do
        board.place(ship_1, coordinates_2)
        expect(board.cells["A1"].ship).to be nil
        expect(board.cells["A3"].ship).to be nil
        expect(board.cells["B4"].ship).to be nil
      end
    end
  end

  describe "#valid_coordinate?" do
    context "when there is an invalid coordinate" do
      it "returns false" do
        expect(board.valid_coordinate?("invalid coordinate")).to be false
      end
    end

    context "when there is a valid coordinate" do
      it "returns true" do
        expect(board.valid_coordinate?("B3")).to be true
      end
    end
  end

  describe "#valid_placement?" do
    context "when there is a ship in the cell" do
      it "returns false" do
        expect(board.valid_placement?(ship_2, coordinates_1)).to be true
        board.cells["A1"].place_ship(ship_2)
        expect(board.valid_placement?(ship_2, coordinates_1)).to be false
      end
    end
    context "when array length does not match ship length" do
      it "returns false" do
        expect(board.valid_placement?(ship_1, coordinates_1)).to be false
      end
    end

    context "when array length does match ship length" do
      it "returns true" do
        expect(board.valid_placement?(ship_2, coordinates_1)).to be true
      end
    end

    context "when coordinates are not consecutive or diagonal" do
      it "returns false" do
        expect(board.valid_placement?(ship_1, coordinates_2)).to be false
      end
    end

    context "when are coordinates are consecutive and not diagonal" do
      it "returns true" do
        expect(board.valid_placement?(ship_2, coordinates_1)).to be true
      end
    end
  end

  describe "#render" do
    context "when show_ships is false" do
      it "prints misses, hits, and sunken ships" do
        expect(board.render(false)).to eq blank_board

        board.place(ship_2, coordinates_1)
        expect(board.render(false)).to eq blank_board
        board.cells["A1"].fire_upon
        expect(board.render(false)).to eq hit_board
        board.cells["B1"].fire_upon
        expect(board.render(false)).to eq miss_board
        board.cells["A2"].fire_upon
        expect(board.render(false)).to eq sunk_board
      end
    end
    context "when show_ships is true" do
      it "prints ships, misses, hits, and sunken ships" do
        expect(board.render(true)).to eq blank_board
        board.place(ship_2, coordinates_1)
        expect(board.render(true)).to eq ship_board
        board.cells["A1"].fire_upon
        expect(board.render(true)).to eq hit_board_ship
        board.cells["B1"].fire_upon
        expect(board.render(true)).to eq miss_board_ship
        board.cells["A2"].fire_upon
        expect(board.render(true)).to eq sunk_board
       end
    end
  end
end
