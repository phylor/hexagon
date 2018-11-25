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
end
