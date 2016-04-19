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

  describe '#deduct' do

    it 'deduct money when used' do
      oystercard.top_up(30)
      oystercard.deduct(15)
      expect(oystercard.balance).to eq 15
    end

  end

  describe '#touch_in' do

    it 'begins the journey' do
      oystercard.top_up(Oystercard::MAX_LIMIT)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it "cannot begin journey if balance less than #{Oystercard::MIN_LIMIT}" do
      message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
      expect{oystercard.touch_in}.to raise_error message
    end

  end

  describe '#touch_out' do

    it 'ends the journey' do
      oystercard.top_up(Oystercard::MAX_LIMIT)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

  end

end