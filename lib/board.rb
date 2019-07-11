require "./lib/cell"

class Board
  attr_accessor :cells, :final_render

  def initialize
    @cells = generate_board
    @final_render = initialize_render
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each { |coordinate| cells[coordinate].place_ship(ship) }
    end
  end

  def render(show_ship=false)
    cells.values.each do |cell|
      final_render[cell.coordinate][0] = cell.render(show_ship)
    end

    final_render.values.join
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if coordinates.detect { |coordinate| cells[coordinate].ship != nil }
      false
    elsif ship.length != coordinates.length
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
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
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

  def initialize_render
    {
      "line_1" => "  1 2 3 4 \n",
      "A"  => "A ",
      "A1" => ". ",
      "A2" => ". ",
      "A3" => ". ",
      "A4" => ". \n",
      "B"  => "B ",
      "B1" => ". ",
      "B2" => ". ",
      "B3" => ". ",
      "B4" => ". \n",
      "C"  => "C ",
      "C1" => ". ",
      "C2" => ". ",
      "C3" => ". ",
      "C4" => ". \n",
      "D"  => "D ",
      "D1" => ". ",
      "D2" => ". ",
      "D3" => ". ",
      "D4" => ". \n",
    }
  end
end
