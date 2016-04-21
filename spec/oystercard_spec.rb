require 'oystercard'

describe Oystercard do

  let(:journeylog){ spy(:journelog) }
  subject(:oystercard){ described_class.new(journeylog) }
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
    it 'calls begin on the journeylog' do
      oystercard.top_up(10)
      oystercard.touch_in(startstation)
      expect(journeylog).to have_received(:begin).with(startstation,oystercard)
    end
  end
    
  describe '#touch_out' do
    it 'calls finish on the journeylog' do
      oystercard.touch_out(endstation)
      expect(journeylog).to have_received(:finish).with(endstation,oystercard)
    end
  end
  
  describe "When there is less than #{Oystercard::MIN_LIMIT}" do
    it "cannot begin journey" do
      message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
      expect{oystercard.touch_in(startstation)}.to raise_error message
    end
  end

  describe '#deduct' do
    let(:incomplete_journey){ double(:journey, complete?: false) }
    let(:complete_journey){ double(:journey, complete?: true)}
    it 'deducts the penalty fare if the journey passes in is not complete' do
      expect{oystercard.deduct(incomplete_journey)}.to change{oystercard.balance}.by -6
    end
    it 'deducts the standard fare if the journey passed in is complete' do
      expect{oystercard.deduct(complete_journey)}.to change{oystercard.balance}.by -1
    end
  end

  describe '#past_journeys' do
    it 'asks journey log for its journey history' do
      oystercard.past_journeys
      expect(journeylog).to have_received(:journey_history)
    end
  end

end