require "./lib/ship"
require "./lib/cell"

RSpec.describe Cell do
  let(:ship) { Ship.new("Boaty McBoatface", 3) }
  let(:cell) { Cell.new("B4") }

  describe "#initialize" do
    it "takes a coordinate" do
      expect(cell.coordinate).to eq "B4"
    end
  end

  describe "#empty?" do
    context "when there is no ship" do
      it "returns false" do
        expect(cell.empty?).to eq (cell.ship == nil)
      end
    end
    context "when there is a ship" do
      it "returns true" do
        expect(cell.empty?).to eq (cell.ship != ship)
      end
    end
  end

  describe "#fired_upon?" do
    context "when cell has not been hit" do
      it "returns false" do
        expect(cell.fired_upon?).to be false
      end
    end
    context "when cell has been hit" do
      it "returns true" do
        cell.fire_upon
        expect(cell.fired_upon?).to be true
      end
    end
  end

  describe "#fire_upon" do
    context "when there is a ship" do
      it "reduces the ships health" do
        expect(ship.health).to eq 3
        expect(cell.fired_upon?).to be false
        cell.place_ship(ship)
        cell.fire_upon
        expect(ship.health).to eq 2
        expect(cell.fired_upon?).to be true
      end
    end
    context "when there is not a ship" do
      it "fired_upon becomes true" do
        expect(cell.ship).to be nil
        expect(cell.fired_upon?).to be false
        cell.fire_upon
        expect(cell.fired_upon?).to be true
      end
    end
  end

  describe "#place_ship" do
    it "takes a ship and puts it on the coordinate" do
      expect(cell.ship).to be nil
      cell.place_ship(ship)
      expect(cell.ship).to eq ship
    end
  end

  describe "#render" do
    context "when the cell has not been fired on" do
      it "prints a ." do
        expect(cell.render).to eq "."
      end
    end
    context "when the cell has been fired on and it does not contain a ship" do
      it "prints a M" do
        cell.fire_upon
        expect(cell.render).to eq "M"
      end
    end
    context "when the cell has been fired on and it contains a ship" do
      it "prints a H" do
        cell.place_ship(ship)
        cell.fire_upon
        expect(cell.render).to eq "H"
      end
    end
    context "when the cell has been fired on and its ship has been sunk" do
      it "prints a X" do
        cell.place_ship(ship)
        cell.fire_upon
        2.times { ship.hit }
        expect(cell.render).to eq "X"
      end
    end
  end
end
