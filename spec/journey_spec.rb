require 'journey'

describe Journey do
    
  subject(:journey) { described_class.new }
  let(:station) { double :station }
  let(:card) {double :card, deduct: nil}
   
  
  describe '#end_journey' do
    it 'store the end station' do
      journey.end_journey(station,card)
      expect(journey.end_station).to eq station
    end
    it 'if start_station has been set, it deducts normal fare from card' do
      journey.start_journey(station)
      expect(card).to receive(:deduct).with(1)
      journey.end_journey(station,card)
    end
    it 'if start_station has not been set, it does not deduct normal fare from card' do
      expect(card).not_to receive(:deduct).with(1)
      journey.end_journey(station,card)
    end
  end
  
  describe '#start_journey' do
    it 'stores the start station' do
      journey.start_journey(station)
      expect(journey.start_station).to eq station
    end
  end

  describe '#completed?' do
    it "returns false if a journey hasn't ended" do
      expect(journey.completed?).to eq false
    end
    it 'ends the journey' do
      journey.end_journey(station,card)
      expect(journey).to be_completed
    end 
  end
  
  describe '#levy_penalty' do
  
    it 'tells card to deduct penalty amount' do
      expect(card).to receive(:deduct).with(6)
      journey.levy_penalty(card)
    end
  end
    
end