class Hexagon::Map
  attr_reader :layout

  def initialize(map_shape, orientation, columns, rows, origin, hexagon_size)
    @layout = Hexagon::Layout.new(origin, hexagon_size, orientation)
    @hexagons = Set.new

    send("shape_#{map_shape}", columns, rows)
  end

  def each(&block)
    @hexagons.each(&block)
  end

  private

  def shape_parallelogram_right(columns, rows)
    (0...columns).each do |column|
      (0...rows).each do |row|
        @hexagons.add(Hexagon::Hex.new(column, row))
      end
    end
  end

  def shape_parallelogram_left(columns, rows)
    (0...columns).each do |r|
      (0...rows).each do |s|
        @hexagons.add(Hexagon::Hex.new(-r - s, r, s))
      end
    end
  end

  def shape_parallelogram_middle(columns, rows)
    (0...columns).each do |s|
      (0...rows).each do |q|
        @hexagons.add(Hexagon::Hex.new(q, -q - s, s))
      end
    end
  end

  def shape_triangle_a(columns, rows)
    (0...columns).each do |q|
      (0...rows - q).each do |r|
        @hexagons.add(Hexagon::Hex.new(q, r))
      end
    end
  end

  def shape_triangle_b(columns, rows)
    (0...columns).each do |q|
      (rows - q...rows).each do |r|
        @hexagons.add(Hexagon::Hex.new(q, r))
      end
    end
  end

  def shape_hexagon(radius, _rows)
    radius /= 2
    (-radius+1...radius).each do |q|
      r1 = [-radius, -q - radius].max
      r2 = [radius, -q + radius].min

      (r1+1...r2).each do |r|
        @hexagons.add(Hexagon::Hex.new(q, r))
      end
    end
  end

  def shape_rectangle_a(columns, rows)
    (0...rows).each do |r|
      r_offset = (r / 2.0).floor

      (-r_offset...columns - r_offset).each do |q|
        @hexagons.add(Hexagon::Hex.new(q, r))
      end
    end
  end

  def shape_rectangle_b(columns, rows)
    (0...columns).each do |q|
      q_offset = (q / 2.0).floor

      (-q_offset...rows - q_offset).each do |r|
        @hexagons.add(Hexagon::Hex.new(q, r))
      end
    end
  end
end
