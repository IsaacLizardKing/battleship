require "./lib/board"
require "pry"
class Game
  attr_accessor :computer_board, :player_board

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    play

  end

  def play
    generate_computer_board
  end

  def generate_computer_board
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    place_computer_ship(cruiser)
    place_computer_ship(submarine)
  end

  def place_computer_ship(ship)
    loop do
      coordinates = computer_board.cells.keys.sample(ship.length)
      if computer_board.place(ship, coordinates).nil?
        break
      end
    end
  end
end
