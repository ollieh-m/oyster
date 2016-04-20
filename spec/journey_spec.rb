require 'journey'

describe Journey do
    
  subject(:journey) { described_class.new(:start_station) }
  let (:station) { double :station }
   
  it 'on initialization sets start station' do
    expect(journey.start_station).to eq :start_station
  end
  
  describe '#end_journey' do
  
    it 'ends the journey' do
      journey.end_journey(station)
      expect(journey).to be_ended
    end        
    
    it 'store the final station' do
      journey.end_journey(station)
      expect(journey.end_station).to eq station
    end
    
  end
    
    
end