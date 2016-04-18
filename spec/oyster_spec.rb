require 'oyster'

describe Oyster do
  subject(:oyster) {described_class.new}
  let(:oyster_topped_up) do
    oyster = Oyster.new
    oyster.top_up(min_fare)
    oyster.touch_in
    oyster
  end
  let(:min_fare) {Oyster::MIN_FARE}

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

  context 'touching in and out' do
    it 'is initially not in a journey' do
      expect(oyster).not_to be_in_journey
    end

    it 'expects in_journey? to return true having touched in with balance at least 1' do
      expect(oyster_topped_up).to be_in_journey
    end

    it 'expects in_journey? to return false having touched out' do
      oyster_topped_up.touch_out
      expect(oyster_topped_up).not_to be_in_journey
    end

    it 'should raise an error when touching in with balance less than 1' do
      oyster.top_up(min_fare-1)
      expect{oyster.touch_in}.to raise_error "Balance must be at least £1"
    end

    it 'should decrease balance by MIN_FARE when touch out' do
      expect {oyster_topped_up.touch_out}.to change{oyster_topped_up.balance}.by(-min_fare)
    end
  end

end