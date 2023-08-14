require 'bandoleer'

# Example implementation of a bandoleer module.
module BasicBandoleer
  extend Bandoleer
end

describe Bandoleer do
  it 'equips new constants from files via Arrays of Symbols' do
    BasicBandoleer.equip [:basic_one, :basic_two]
    expect(BasicBandoleer.keys.size).to eql(2)
  end

  it 'returns all equipped keys' do
    expect(BasicBandoleer.equipped).to eql([:basic_one, :basic_two])
  end

  it 'resolves vials via slicing' do
    expect(BasicBandoleer[:basic_one]).to eql(BasicOne)
  end

  it 'resolves vials via methods' do
    expect(BasicBandoleer.basic_two).to eql(BasicTwo)
  end

  it 'equips new constants from files via Strings' do
    BasicBandoleer.equip 'basic_three'
    expect(BasicBandoleer.basic_three).to eql(BasicThree)
  end

  it 'equips custom components' do
    BasicBandoleer.equip_custom basic_four: -> { BasicFour.report }
    expect(BasicBandoleer.basic_four.call).to eql('report four!')
  end
end
