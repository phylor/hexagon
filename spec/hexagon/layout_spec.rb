require 'hexagon/layout'

RSpec.describe Hexagon::Layout do
  it 'returns pixel coordinates of single hexagon at the center' do
    layout = Hexagon::Layout.new([0, 0], [50, 50], :pointy)
    hex = Hexagon::Hex.new(0, 0)

    expect(layout.to_pixel(hex)).to eq [0, 0]
  end

  it 'eastern neighbor has an x offset' do
    layout = Hexagon::Layout.new([0, 0], [50, 50], :pointy)
    hex = Hexagon::Hex.new(1, 0)

    expect(layout.to_pixel(hex)).to eq [50, 0]
  end

  it 'southeastern neighbor' do
    layout = Hexagon::Layout.new([0, 0], [50, 50], :pointy)
    hex = Hexagon::Hex.new(0, 1)

    expect(layout.to_pixel(hex)).to eq [25, 0.75 * 50]
  end

  it 'southwestern neighbor' do
    layout = Hexagon::Layout.new([0, 0], [50, 50], :pointy)
    hex = Hexagon::Hex.new(-1, 1)

    expect(layout.to_pixel(hex)).to eq [-25, 0.75 * 50]
  end

  it 'eastern neighbor with an offset' do
    layout = Hexagon::Layout.new([100, 100], [50, 50], :pointy)
    hex = Hexagon::Hex.new(1, 0)

    expect(layout.to_pixel(hex)).to eq [150, 100]
  end

  it 'returns hexagon of centered pixels at origin' do
    layout = Hexagon::Layout.new([0, 0], [50, 50], :pointy)

    expect(layout.to_hexagon([0, 0])).to eq Hexagon::Hex.new(0, 0)
  end

  it 'returns hexagon of centered pixels' do
    layout = Hexagon::Layout.new([0, 0], [50, 50], :pointy)

    expect(layout.to_hexagon([25, 25])).to eq Hexagon::Hex.new(0, 1)
  end

  it 'returns hexagon of centered pixels with origin offset' do
    layout = Hexagon::Layout.new([100, 200], [50, 50], :pointy)

    expect(layout.to_hexagon([125, 225])).to eq Hexagon::Hex.new(0, 1)
  end

  it 'returns hexagon of random pixels' do
    layout = Hexagon::Layout.new([0, 0], [50, 50], :pointy)

    expect(layout.to_hexagon([0.25 * 50, 3 / 8.0 * 50])).to eq Hexagon::Hex.new(0, 0)
  end
end
