require 'oystercard'

describe Oystercard do

  subject(:oystercard){ described_class.new }

  it { is_expected.to respond_to(:balance) }

  it 'has a default balance of 0 on initialization' do
    expect(oystercard.balance).to eq 0
  end

  it 'tops up the balance' do
  	expect{oystercard.top_up(20)}.to change{oystercard.balance}.by 20
  end

it 'has a maximum limit of £90' do
    # oystercard.top_up(90)
    oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
    expect { oystercard.top_up(1) }.to raise_error "cannot top up beyond £#{Oystercard::MAXIMUM_BALANCE} maximum"
  end


end