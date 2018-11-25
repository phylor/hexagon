class Hexagon::Layout
  attr_reader :origin, :size, :orientation

  def initialize(origin, hexagon_size, orientation = :flat)
    @origin = origin
    @size = hexagon_size
    @orientation = case orientation
                   when :flat
                     Hexagon::Orientation::FLAT
                   when :pointy
                     Hexagon::Orientation::POINTY
                   end
  end

  def to_pixel(hexagon)
    x = (orientation.f0 * hexagon.q + orientation.f1 * hexagon.r) * size[0]
    y = (orientation.f2 * hexagon.q + orientation.f3 * hexagon.r) * size[1]

    [x + origin[0], y + origin[1]]
  end

  def to_hexagon(pixel)
    x = (pixel[0] - origin[0]) / size[0]
    y = (pixel[1] - origin[1]) / size[1]

    q = orientation.b0 * x + orientation.b1 * y
    r = orientation.b2 * x + orientation.b3 * y

    Hexagon::Hex.new(q, r)
  end
end
