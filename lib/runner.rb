require "./lib/game"
puts "Welcome to BATTLESHIP!"
loop do
  puts "Enter p to play. Enter q to quit."
  answer = gets.chomp!.upcase
  case answer
  when "P"
    game = Game.new
    game.play
  when "Q"
    break
  else
    puts "Invalid input."
  end
end
