require 'oyster'

describe Oyster do
  subject(:oyster) {described_class.new}

  it 'has a balance of 0 when initialized' do
    expect(oyster.balance).to eq 0
  end

  context '#top_up' do
  	it 'should increase the balance by the amount passed' do
  		oyster.top_up(20)
  		expect(oyster.balance).to eq 20
  	end
    it 'should raise an error if trying to exceed limit' do
      oyster.top_up(Oyster::LIMIT)
      expect{oyster.top_up(1)}.to raise_error "Balance cannot exceed #{Oyster::LIMIT}!"
    end
  end

  context '#deduct' do
    it 'should decrease the balance by the amount passed' do
      oyster.deduct(20)
      expect(oyster.balance).to eq -20
    end
  end

  context 'touching in and out' do
    it 'is initially not in a journey' do
      expect(oyster).not_to be_in_journey
    end

    it 'expects in_journey? to return true having touched in with balance at least 1' do
      oyster.top_up(Oyster::MIN_BALANCE)
      oyster.touch_in
      expect(oyster).to be_in_journey
    end

    it 'expects in_journey? to return false having touched out' do
      oyster.top_up(Oyster::MIN_BALANCE)
      oyster.touch_in
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end

    it 'should raise an error when touching in with balance less than 1' do
      oyster.top_up(Oyster::MIN_BALANCE-1)
      expect{oyster.touch_in}.to raise_error "Balance must be at least £1"
    end
  end

end