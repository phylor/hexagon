require 'hexagon/hex'

RSpec.describe Hexagon::Hex do
  it 'creates with cube coordinates' do
    hex = Hexagon::Hex.new(1, 2, -3)

    expect(hex.q).to be 1
    expect(hex.r).to be 2
    expect(hex.s).to be -3
  end

  it 'creates with axial coordinates' do
    hex = Hexagon::Hex.new(4, 5)

    expect(hex.q).to be 4
    expect(hex.r).to be 5
    expect(hex.s).to be -9
  end

  it 'raises when coordinates do not sum up to 0' do
    expect { Hexagon::Hex.new(1, 2, 3) }.to raise_error(RuntimeError)
  end

  it 'equals to another hexagon with the same coordinates' do
    hex1 = Hexagon::Hex.new(1, 2, -3)
    hex2 = Hexagon::Hex.new(1, 2, -3)

    expect(hex1).to eq(hex2)
  end

  it 'does not equal to another hexagon with different coordinates' do
    hex1 = Hexagon::Hex.new(1, 2, -3)
    hex2 = Hexagon::Hex.new(1, 3, -4)

    expect(hex1).not_to eq(hex2)
  end

  it 'adds two hexagons' do
    hex1 = Hexagon::Hex.new(1, 2, -3)
    hex2 = Hexagon::Hex.new(2, 0, -2)

    sum = Hexagon::Hex.new(3, 2, -5)
    expect(hex1 + hex2).to eq(sum)
  end

  it 'subtracts two hexagons' do
    hex1 = Hexagon::Hex.new(1, 2, -3)
    hex2 = Hexagon::Hex.new(2, 0, -2)

    difference = Hexagon::Hex.new(-1, 2, -1)
    expect(hex1 - hex2).to eq(difference)
  end

  it 'multiplies with a scalar' do
    hex = Hexagon::Hex.new(1, 2, -3)

    multiplied = Hexagon::Hex.new(3, 6, -9)
    expect(hex * 3).to eq(multiplied)
  end

  it 'calculates distance to itself' do
    hex = Hexagon::Hex.new(1, 2, -3)

    expect(hex.distance_to(hex)).to be 0
  end

  it 'calculates distance to a hexagon just to the right' do
    hex1 = Hexagon::Hex.new(1, 2, -3)
    hex2 = Hexagon::Hex.new(2, 1, -3)

    expect(hex1.distance_to(hex2)).to be 1
  end

  it 'calculates distance to a hexagon further away, but on the same axis' do
    hex1 = Hexagon::Hex.new(1, 2, -3)
    hex2 = Hexagon::Hex.new(1, -2, 1)

    expect(hex1.distance_to(hex2)).to be 4
  end

  it 'calculates distance to a hexagon further away on different axis' do
    hex1 = Hexagon::Hex.new(1, 2, -3)
    hex2 = Hexagon::Hex.new(-1, -1, 2)

    expect(hex1.distance_to(hex2)).to be 5
  end
end
