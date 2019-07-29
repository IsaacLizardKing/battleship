require "./lib/game"

RSpec.describe Game do
  let (:game) { Game.new }
  let (:computer_board) { Board.new }
  let (:player_board) { Board.new }
  let (:computer_cruiser) { Ship.new("Cruiser", 3) }
  let (:computer_submarine) { Ship.new("Submarine", 2) }

  describe "#initialize" do
    it "creates computer and player boards, cruisers, and submarines" do
      expect(game.computer_board).to be_instance_of Board
      expect(game.player_board).to be_instance_of Board
      expect(game.computer_cruiser).to be_instance_of Ship
      expect(game.computer_submarine).to be_instance_of Ship
    end
  end
end
