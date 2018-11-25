# Stores the position of a hexagon in cube coordinates
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

  def length
    (q.abs + r.abs + s.abs) / 2
  end

  def distance_to(o)
    (o - self).length
  end

  def neighbor(direction)
    raise ArgumentError unless DIRECTIONS.has_key?(direction)

    self + DIRECTIONS[direction]
  end

  def round
    rx = q.round
    ry = r.round
    rz = s.round

    x_diff = (rx - q).abs
    y_diff = (ry - r).abs
    z_diff = (rz - s).abs

    if x_diff > y_diff && x_diff > z_diff
      rx = - ry - rz
    elsif y_diff > z_diff
      ry = - rx - rz
    else
      rz = - rx - ry
    end

    @q = rx
    @r = ry
    @s = rz

    self
  end

  protected

  DIRECTIONS = {
    northeast: Hexagon::Hex.new(1, 0, -1),
    east:      Hexagon::Hex.new(1, -1, 0),
    southeast: Hexagon::Hex.new(0, -1, 1),
    southwest: Hexagon::Hex.new(-1, 0, 1),
    west:      Hexagon::Hex.new(-1, 1, 0),
    northwest: Hexagon::Hex.new(0, 1, -1)
  }

  def coordinates
    [q, r, s]
  end
end
