require './lib/board'

class Game
  attr_accessor :computer_board,
                :computer_cruiser,
                :computer_submarine,
                :player_board,
                :player_cruiser,
                :player_submarine

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    play
  end

  def play
    generate_computer_board
    puts computer_board.render(true)
    puts "Captain Macaroni has placed his ships on his grid."
    puts "You now need to place your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    puts player_board.render
    puts "Enter the squares for the Cruiser (3 spaces)"
    place_player_ships(player_cruiser)
    puts "Enter the squares for the Submarine (2 spaces)"
    place_player_ships(player_submarine)
  end

  def generate_computer_board

    place_computer_ship(computer_cruiser)
    place_computer_ship(computer_submarine)
  end

  def place_computer_ship(ship)
    loop do
      coordinates = computer_board.cells.keys.sample(ship.length)
      if !computer_board.place(ship, coordinates).nil?
        break
      end
    end
  end

  def place_player_ships(ship)
    loop do
      coordinates = gets.chomp.upcase.split(" ")
      if !player_board.place(ship, coordinates).nil?
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
    puts player_board.render(true)
  end
end
