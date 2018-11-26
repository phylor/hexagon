require 'gl'
require 'gtk2'
require 'gosu'

class MapVisualizer < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize(map_shape, orientation, offset)
    super(WIDTH, HEIGHT)

    @map_shape, @orientation = map_shape, orientation
    @map = Hexagon::Map.new(map_shape, orientation, 8, 8, offset, [40, 40])
    @font = Gosu::Font.new(20)
  end

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::GRAY)

    @font.draw_text("#{@map_shape} / #{@orientation}", 25, 25, 1, 1, 1, Gosu::Color::BLACK)

    @map.each do |hexagon|
      corners = @map.layout.corners(hexagon)
      corners << corners[0]

      corners.each_cons(2).each do |first, second|
        Gosu.draw_line(
          first[0], first[1], Gosu::Color::BLACK,
          second[0], second[1], Gosu::Color::BLACK,
          1
        )
      end
    end

    screenshot
    close!
  end

  def screenshot
    data = nil

    gl do
      data = Gl::glReadPixels( 0, 0, WIDTH - 1, HEIGHT - 1, Gl::GL_RGB, Gl::GL_UNSIGNED_BYTE)
    end

    screenbuffer = GdkPixbuf::Pixbuf.new(data: data, colorspace: :rgb, has_alpha: false, bits_per_sample: 8, width: WIDTH - 1, height: HEIGHT - 1)
    screenbuffer.flip(false).save("/tmp/#{@map_shape}_#{@orientation}.png", 'png')
  end
end

def check_map(shape, orientation, offset)
  MapVisualizer.new(shape, orientation, offset).show

  expect("/tmp/#{shape}_#{orientation}.png").to be_same_file_as("spec/files/map/#{shape}_#{orientation}.png")
end

RSpec.describe Hexagon::Map do
  it 'generates correct maps' do
    check_map(:parallelogram_right, :pointy, [50, 100])
    check_map(:parallelogram_middle, :pointy, [350, 450])
    check_map(:parallelogram_left, :pointy, [550, 100])

    check_map(:parallelogram_right, :flat, [200, 75])
    check_map(:parallelogram_middle, :flat, [150, 425])
    check_map(:parallelogram_left, :flat, [550, 250])

    check_map(:triangle_a, :pointy, [150, 100])
    check_map(:triangle_b, :pointy, [0, 100])

    check_map(:triangle_a, :flat, [150, 100])
    check_map(:triangle_b, :flat, [100, 0])

    check_map(:hexagon, :pointy, [300, 200])
    check_map(:hexagon, :flat, [300, 200])

    check_map(:rectangle_a, :pointy, [50, 100])
    check_map(:rectangle_b, :pointy, [150, 200])

    check_map(:rectangle_a, :flat, [250, 100])
    check_map(:rectangle_b, :flat, [50, 100])
  end
end
