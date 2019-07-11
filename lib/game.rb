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
    cruiser_coordinates = []
    loop do
      3.times { cruiser_coordinates.push(computer_board.cells.keys.sample)}
      binding.pry
      if !computer_board.place(cruiser, ["A1", "A2", "A3"]).nil?
        break
      end
    end

  end
end
