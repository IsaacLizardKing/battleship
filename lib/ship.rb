class Ship
  attr_reader :length, :name
  attr_accessor :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def hit
    @health = health - 1 unless health == 0
  end

  def sunk?
    health == 0
  end
end
