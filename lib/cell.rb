require "./lib/ship"

class Cell
  attr_reader :coordinate,
              :ship

  attr_accessor :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @fired_upon = false
  end

  def empty?
    ship == nil
  end

  def fired_upon?
    fired_upon
  end

  def fire_upon
    if !empty? && !fired_upon?
      ship.health -= 1
    end

    self.fired_upon = true
  end

  def place_ship(ship)
    @ship = ship
  end

  def render(show_ship=false)
    if !fired_upon?
      if show_ship && !empty?
        "S"
      else
        "."
      end
     elsif empty?
       "M"
     elsif !ship.sunk?
       "H"
     else
       "X"
     end
  end
end
