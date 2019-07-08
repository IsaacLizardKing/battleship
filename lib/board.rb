require "../lib/cell"

class Board
  attr_accessor :cells

  def initialize
    @cells = generate_board
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      false
    elsif !consecutive?(coordinates)
      false
    else
      true
    end
  end

private

  def consecutive?(coordinates)
    if coordinates.length > 4
      return false
    end

    if coordinates.all? { |coordinate| coordinate[0] == coordinates[0][0] }
      range = (coordinates[0][1]..coordinates[-1][1]).to_a
      range.size == coordinates.size
    elsif coordinates.all? { |coordinate| coordinate[1] == coordinates[0][1] }
      range = (coordinates[0][0]..coordinates[-1][0]).to_a
      range.size == coordinates.size
    end
  end

  def generate_board
    { "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A1"),
      "A4" => Cell.new("A1"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end
end
