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

  describe '#exit_nil?' do
    it 'returns true if @end_station has not been set' do
      journey.start_journey(station1)
      expect(journey.exit_nil?).to eq true
    end
  end

  describe '#complete?' do
    it 'returns true if entry and exit stations have been set' do
      journey.start_journey(station1)
      expect{journey.end_journey(station2)}.to change{journey.complete?}.to true
    end
  end

end