class Ship
  attr_reader :length, :name
  attr_accessor :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def hit
    self.health -= 1 unless health.zero?
  end

  def sunk?
    health.zero?
  end
end
