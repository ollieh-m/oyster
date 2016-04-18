require 'oyster'

describe Oyster do
  subject(:oyster) {described_class.new}

  it 'has a balance of 0 when initialized' do
    expect(oyster.balance).to eq 0
  end

end