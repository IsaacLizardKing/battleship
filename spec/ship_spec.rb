require "./lib/ship"

RSpec.describe Ship do
  let(:ship) { Ship.new("Boaty McBoatface", 3) }

  describe "#initialize" do
    it "takes a name and length" do
      expect(ship.name).to eq "Boaty McBoatface"
      expect(ship.length).to eq 3
      expect(ship.health).to eq 3
    end
  end

  describe "#sunk?" do
    context "when boat's health is 0" do
      it "returns true" do
        expect(ship.sunk?).to eq (ship.health == 0)
        3.times { ship.hit }
        expect(ship.sunk?).to eq (ship.health == 0)
      end
    end
    context "when boat's health is not 0" do
      it "returns false" do
        expect(ship.sunk?).to eq (ship.health < 1)
      end
    end
  end

  describe "#hit" do
    it "reduces the health of the ship" do
      expect(ship.health).to eq 3
      ship.hit
      expect(ship.health).to eq 2
    end
  end
end
