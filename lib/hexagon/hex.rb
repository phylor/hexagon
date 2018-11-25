# Stores in cube coordinates
class Hexagon::Hex
  attr_reader :q, :r, :s

  alias_method :eql?, :==

  def initialize(q, r, s = -q - r)
    raise unless q + r + s == 0

    @q = q
    @r = r
    @s = -q - r
  end

  def ==(o)
    o.class == self.class && o.coordinates == coordinates
  end

  def hash
    coordinates.hash
  end

  def +(o)
    Hexagon::Hex.new(q + o.q, r + o.r)
  end

  def -(o)
    Hexagon::Hex.new(q - o.q, r - o.r)
  end

  def *(o)
    Hexagon::Hex.new(o * q, o * r)
  end

  protected

  def coordinates
    [q, r, s]
  end
end
