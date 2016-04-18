require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it 'defaults with balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'can be topped up' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
  end

  it 'takes maximum balance of 90' do
    oystercard.top_up(Oystercard::MAX_LIMIT)
    message = "Maximum limit of £#{Oystercard::MAX_LIMIT}."
    expect { oystercard.top_up(1) }.to raise_error message
  end

  it 'deduct money when used' do
    oystercard.top_up(30)
    oystercard.deduct(15)
    expect(oystercard.balance).to eq 15

  end

end