require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it 'defaults with balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do

    it 'increase the balance' do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it 'cannot increase the balance beyond limit' do
      message = "No more than #{Oystercard::MAX_LIMIT} in balance!"
      expect{oystercard.top_up(Oystercard::MAX_LIMIT+1)}.to raise_error message
    end

  end


  context 'when there is enough money for a trip' do

    before(:each) do
      oystercard.top_up(Oystercard::MAX_LIMIT)
      oystercard.touch_in
    end

    it 'deducts minimum fare on touch out' do
      expect {oystercard.touch_out}.to change{oystercard.balance}.by(-1)
    end
    
    it '#touch_in' do
      expect(oystercard).to be_in_journey
    end

    it '#touch_out' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

  end

  context "When there is less than #{Oystercard::MIN_LIMIT}" do

    it "cannot begin journey" do
      message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
      expect{oystercard.touch_in}.to raise_error message
    end

  end

end