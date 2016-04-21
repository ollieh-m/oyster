require 'oystercard'

describe Oystercard do

  let(:journey) { spy(:journey) }
  subject(:oystercard) { described_class.new(journey) }
  let(:startstation) { double(:station) }
  let(:endstation) { double(:station) }
 
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

  describe '#touch_in' do
    it 'makes the journey start' do
      oystercard.top_up(Oystercard::MAX_LIMIT)
      oystercard.touch_in(startstation)
      expect(journey).to have_received(:start_journey).with(startstation,oystercard)
    end
  end
    
  describe '#touch_out' do
    it 'makes the journey end' do
      expect(journey).to receive(:end_journey).with(endstation,oystercard)
      oystercard.touch_out(endstation)
    end
  end
  
  describe "When there is less than #{Oystercard::MIN_LIMIT}" do
    it "cannot begin journey" do
      message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
      expect{oystercard.touch_in(startstation)}.to raise_error message
    end
  end

  describe '#deduct' do
    it 'reduces card balance by the amount given' do
      oystercard.top_up(20)
      expect{oystercard.deduct(5)}.to change{oystercard.balance}.by(-5)
    end
  end

  describe '#add_to_log' do
    it 'adds the given journey to journey history' do
      oystercard.add_to_log(startstation,endstation)
      expect(oystercard.journey_history).to include({entrystation: startstation, exitstation: endstation})
    end
  end

end