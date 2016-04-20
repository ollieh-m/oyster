require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }
  let(:journey) { double(:journey, start_journey: nil, end_journey: 'fish', levy_penalty: nil ) }
 
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
    end

    describe '#touch_in' do
      it 'sets the start station in the journey object when not already touched in' do
        expect(journey).to receive(:start_journey).with(station)
        oystercard.touch_in(station,journey)
      end  

      it 'records the journey into journey history' do
        oystercard.touch_in(station, journey)
        expect(oystercard.journey_history.last).to eq journey
      end
      
      it 'tells journey a penalty is needed if card is already touched in' do
        oystercard.touch_in(station,journey)
        expect(journey).to receive(:levy_penalty).with(oystercard)
        oystercard.touch_in(station, journey)
      end
    end
    
    describe '#touch_out' do
      it 'gives last journey in journey history an end station if already touched in' do
        oystercard.touch_in(station, journey)
        expect(oystercard.journey_history.last).to receive(:end_journey).with(station2)
        oystercard.touch_out(station2)
      end

      it 'tells journey a penalty is needed if already touched out' do
        oystercard.touch_in(station, journey)
        oystercard.touch_out(station2, journey)
        expect(journey).to receive(:levy_penalty).with(oystercard)
        oystercard.touch_out(station2, journey)
      end
      
      it 'creates a new entry in journey_history if not touched in' do
        oystercard.touch_out(station, journey)
        expect(oystercard.journey_history.last).to eq(journey.end_journey(station))  
      end
    end
  end
  
  context "When there is less than #{Oystercard::MIN_LIMIT}" do
    it "cannot begin journey" do
      message = "insufficient funds! Need at least #{Oystercard::MIN_LIMIT}"
      expect{oystercard.touch_in(station)}.to raise_error message
    end
  end

end