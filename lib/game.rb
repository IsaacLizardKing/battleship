require "./lib/board"

class Game
  attr_accessor :computer_board,
                :computer_coordinate,
                :computer_cruiser,
                :computer_submarine,
                :player_board,
                :player_coordinate,
                :player_ships

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @player_ships = []
    play
  end

  def display_boards
    puts "\n==========CAPTAIN MACARONI'S BOARD=========="
    puts computer_board.render
    puts "\n================PLAYER BOARD================"
    puts player_board.render(true)
  end

  def end_game?
    if computer_cruiser.sunk? && computer_submarine.sunk?
      puts "\n================GAME OVER================="
      puts "You won! :)"
      true
    elsif player_ships.all? { |ship| ship.sunk? }
      puts "\n================GAME OVER================="
      puts "Captain Macaroni won. :("
      true
    else
      false
    end
  end

  def get_ship_info
    puts "Ship name?"
    name = gets.chomp.capitalize
    puts "Ship length?"
    length = 0
    loop do
      length = gets.chomp.to_i
      if length < 5 && length > 0
        break
      else
        puts "Please enter a ship length less than 4."
      end
    end
    [name, length]
  end

  def generate_computer_board
    place_computer_ship(computer_cruiser)
    place_computer_ship(computer_submarine)
  end

  def generate_player_board
    generate_player_ships
    puts "\n===============SHIP PLACEMENT=============="
    puts "Captain Macaroni has placed his ships on his grid."
    puts "You now need to place your #{player_ships.size} ships."
    puts player_board.render(true)
    player_ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
      place_player_ships(ship)
    end
  end

  def generate_player_ships
    setup = true
    puts "You need to create your ships."
    while setup  do
      ship = get_ship_info
      self.player_ships.push(Ship.new(ship[0], ship[1]))
      puts "Ship added. Would you like to create another? (y/n)"
      loop do
        answer = gets.chomp
        case answer.downcase
        when "n"
          setup = false
          break
        when "y"
          break
        else
          puts "Please enter y for yes or n for no."
        end
      end
    end
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
      coordinates = STDIN.gets.chomp.upcase.split(" ")
      if !player_board.place(ship, coordinates).nil?
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
    puts player_board.render(true)
  end

  def play
    puts "\n=================SHIP SETUP================"
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
      puts "Captain Macaroni's shot on #{computer_coordinate} sunk your ship!:("
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
    puts "\n==================YOUR TURN================="
    puts "Enter the coordinate for your shot:"
    loop do
      self.player_coordinate = STDIN.gets.chomp.upcase
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
