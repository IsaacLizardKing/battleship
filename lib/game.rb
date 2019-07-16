require './lib/board'
require 'pry'
class Game
  attr_accessor :computer_board,
                :computer_coordinate,
                :computer_cruiser,
                :computer_submarine,
                :player_board,
                :player_coordinate,
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

  def display_boards
    puts "==========CAPTAIN MACARONI'S BOARD=========="
    puts computer_board.render(true)
    puts "================PLAYER BOARD================"
    puts player_board.render(true)
  end

  def end_game?
    if computer_cruiser.sunk? && computer_submarine.sunk?
      puts "You won! :)"
      true
    elsif player_cruiser.sunk? && player_submarine.sunk?
      puts "Captain Macaroni won. :("
      true
    else
      false
    end
  end

  def generate_computer_board
    place_computer_ship(computer_cruiser)
    place_computer_ship(computer_submarine)
  end

  def generate_player_board
    puts "Captain Macaroni has placed his ships on his grid."
    puts "You now need to place your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    puts player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces)"
    place_player_ships(player_cruiser)
    puts "Enter the squares for the Submarine (2 spaces)"
    place_player_ships(player_submarine)
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

  def play
    generate_computer_board
    generate_player_board
    take_turn
  end

  def results
    case computer_board.cells[player_coordinate].render
    when "M"
      puts "Your shot on #{player_coordinate} was a miss."
    when "H"
      puts "Your shot on #{player_coordinate} was a hit!"
    when "X"
      puts "Your shot on #{player_coordinate} sunk a ship!"
    end
    case player_board.cells[computer_coordinate].render
    when "M"
      puts "Captain Macaroni's shot on #{computer_coordinate} was a miss."
    when "H"
      puts "Captain Macaroni's shot on #{computer_coordinate} was a hit!"
    when "X"
      puts "Captain Macaroni's shot on #{computer_coordinate} sunk your ship! :("
    end
  end

  def take_turn
    loop do
      display_boards
      turn_player
      turn_computer
      results
      break if end_game?
    end
  end

  def turn_computer
    loop do
      self.computer_coordinate = player_board.cells.keys.sample
      if player_board.valid_coordinate?(computer_coordinate) &&
         !player_board.cells[computer_coordinate].fired_upon?
        player_board.cells[computer_coordinate].fire_upon
        break
      end
    end
  end

  def turn_player
    puts "Enter the coordinate for your shot:"
    loop do
      self.player_coordinate = gets.chomp.upcase
      if !computer_board.valid_coordinate?(player_coordinate)
        puts "Please enter a valid coordinate:"
      elsif !computer_board.cells[player_coordinate].fired_upon?
        computer_board.cells[player_coordinate].fire_upon
        break
      else
        puts "This cell has already been fired upon. Try again:"
      end
    end
  end
end
