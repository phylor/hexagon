class Hexagon::Orientation
  POINTY = Hexagon::Orientation.new(
    Math.sqrt(3.0), Math.sqrt(3.0) / 2.0, 0.0, 3.0 / 2.0,
    Math.sqrt(3.0) / 3.0, -1.0 / 3.0, 0.0, 2.0 / 3.0,
    0.5
  )

  FLAT = Hexagon::Orientation.new(
    3.0 / 2.0, 0.0, Math.sqrt(3.0) / 2.0, Math.sqrt(3.0),
    2.0 / 3.0, 0.0, -1.0 / 3.0, Math.sqrt(3.0) / 3.0,
    0.0
  )

  def initialize(f0, f1, f2, f3, b0, b1, b2, b3, start_angle)
    @f0, @f1, @f2, @f3 = f0, f1, f2, f3
    @b0, @b1, @b2, @b3 = b0, b1, b2, b3
    @start_angle = start_angle
  end
end
