require 'oystercard'

describe Oystercard do

  subject(:oystercard){ described_class.new }

  context 'balance' do

    it { is_expected.to respond_to(:balance) }
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'has a default balance of 0 on initialization' do
      expect(oystercard.balance).to eq 0
    end

    describe '#top_up' do
      it 'tops up the balance' do
  	    expect{oystercard.top_up(20)}.to change{oystercard.balance}.by +20
      end
    end

    describe '#deduct' do
      it 'deducts a value from balance' do
        expect{oystercard.deduct(20)}.to change{oystercard.balance}.by -20
      end
    end
  end

  it 'has a maximum limit of £90' do
    oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
    expect { oystercard.top_up(1) }.to raise_error "cannot top up beyond £#{Oystercard::MAXIMUM_BALANCE} maximum"
  end

end