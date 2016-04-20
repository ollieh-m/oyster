require 'journey'

describe Journey do
    
  subject(:journey) { described_class.new }
  let (:station) { double :station }
   
  
  describe '#end_journey' do
  
    it 'ends the journey' do
      journey.end_journey(station)
      expect(journey).to be_ended
    end        
    
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
    
    
end