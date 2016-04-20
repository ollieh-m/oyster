require 'journey'

describe Journey do
    
  subject(:journey) { described_class.new }
  let(:station) { double :station }
  let(:card) {double :card, deduct: nil}
   
  
  describe '#end_journey' do
    it 'store the end station' do
      journey.end_journey(station)
      expect(journey.end_station).to eq station
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
      journey.end_journey(station)
      expect(journey).to be_completed
    end 
  end

  describe '#fare' do
    it 'deducts penalty fare if start or end station are nil' do
      expect(card).to receive(:deduct).with(6)
      journey.fare(card)
    end
    it 'deducts standard fare if there is a start and end station' do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(card).to receive(:deduct).with(1)
      journey.fare(card)
    end
  end

  describe '#levy_penalty' do
    it 'tells card to deduct penalty amount' do
      expect(card).to receive(:deduct).with(6)
      journey.levy_penalty(card)
    end
  end
    
end