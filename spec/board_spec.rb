require "../lib/board"

RSpec.describe Board do
  let(:board) { Board.new }
  let(:ship_1) { Ship.new("Boaty McBoatface", 3) }
  let(:ship_2) { Ship.new("Titanic", 2) }
  let(:coordinates_1) { ["A1", "A2"] }
  let(:coordinates_2) { ["A1", "A3", "B4"]}

  describe "#initialize" do
    it "contains a hash of 16 cells" do
      expect(board.cells).to be_kind_of Hash
      expect(board.cells.count).to eq 16
      board.cells.values.all? { |cell| expect(cell).to be_instance_of Cell}
    end
  end

  describe "valid_coordinate?" do
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

  describe "valid_placement?" do
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
end
