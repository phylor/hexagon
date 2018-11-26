require 'hexagon/orientation'
require 'bigdecimal'
require 'bigdecimal/util'

#   0 -1    1 -1
# -1 0   0 0   1 0
#   -1 1    0 1
class Hexagon::Layout
  attr_reader :origin, :size, :orientation

  def initialize(origin, hexagon_size, orientation = :pointy)
    @origin = origin
    @size = [hexagon_size[0] / Math.sqrt(3.0), hexagon_size[1] / 2.0]
    @orientation = case orientation
                   when :pointy
                     Hexagon::Orientation::POINTY
                   when :flat
                     Hexagon::Orientation::FLAT
                   end
  end

  def to_pixel(hexagon)
    x = (orientation.f0 * hexagon.q + orientation.f1 * hexagon.r) * size[0]
    y = (orientation.f2 * hexagon.q + orientation.f3 * hexagon.r) * size[1]

    [x + origin[0], y + origin[1]]
  end

  def to_hexagon(pixel)
    x = (pixel[0].to_d - origin[0].to_d) / size[0].to_d
    y = (pixel[1].to_d - origin[1].to_d) / size[1].to_d

    q = orientation.b0 * x + orientation.b1 * y
    r = orientation.b2 * x + orientation.b3 * y

    Hexagon::Hex.new(q, r).round
  end

  def corners(hexagon)
    center = to_pixel(hexagon)

    (0..5).map do |corner|
      offset = corner_offset(corner)

      [center[0] + offset[0], center[1] + offset[1]]
    end
  end

  private

  def corner_offset(corner)
    angle = 2.0 * Math::PI * (orientation.start_angle + corner) / 6.0

    [size[0] * Math.cos(angle), size[1] * Math.sin(angle)]
  end
end
