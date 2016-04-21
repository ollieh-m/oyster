require 'journey'

describe Journey do
    
  subject(:journey) { described_class.new }
  let(:station1) {double :station}
  let(:station2) {double :station}
  let(:card) {spy :card}
  
  describe '#end_journey' do
    it 'sets @end_station' do
      journey.end_journey(station1)
      expect(journey.end_station).to eq station1
    end
  end
  
  describe '#start_journey' do
    it 'sets @entry_station' do
      journey.start_journey(station1)
      expect(journey.start_station).to eq station1
    end
  end

  describe '#entry_station?' do
    it 'returns false if entry station has not been set' do
      journey.end_journey(station1)
      expect(journey.entry_station?).to eq false
    end
    it 'returns true if entry station has been set' do
      journey.start_journey(station1)
      expect(journey.entry_station?).to eq true
    end
  end

  describe '#complete?' do
    it 'returns true if entry and exit stations have been set' do
      journey.start_journey(station1)
      expect{journey.end_journey(station2)}.to change{journey.complete?}.to true
    end
  end

  describe '#reset' do
    it 'makes start and end stations nil' do
      journey.start_journey(station1)
      expect{journey.reset}.to change{journey.start_station}.to nil
      journey.end_journey(station2)
      expect{journey.reset}.to change{journey.end_station}.to nil
    end
  end

end