require "./lib/board"
require "pry"
class IntelligentComputer
  attr_reader :board
  attr_accessor :coordinates

  def initialize(board)
    @board = board
    @coordinates = []
    find_coordinates
  end

  def find_coordinates
    coordinates.clear
    board.cells.values.each do |cell|
      if cell.hit?
        letter = cell.coordinate[0]
        number = cell.coordinate[1].to_i
        if (letter.ord - 1).between?(65, 68)
          new_coordinate = "#{(letter.ord - 1).chr}#{number}"
          push_coordinates(new_coordinate)
        end
        if (letter.ord + 1).between?(65, 68)
          new_coordinate = "#{(letter.ord + 1).chr}#{number}"
          push_coordinates(new_coordinate)
        end
        if (number - 1).between?(1, 4)
          new_coordinate = "#{letter}#{number - 1}"
          push_coordinates(new_coordinate)
        end
        if (number + 1).between?(1, 4)
          new_coordinate = "#{letter}#{number + 1}"
          push_coordinates(new_coordinate)
        end
      end
    end
    coordinates.sort
  end

  def push_coordinates(new_coordinate)
    if !board.cells[new_coordinate].fired_upon?
      coordinates.push(new_coordinate)
    end
  end
end
