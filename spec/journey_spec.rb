require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:station1) {double :station, zone: 1}
  let(:station2) {double :station, zone: 2}
  let(:station3) {double :station, zone: 2}
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

  describe '#fare' do
    it 'returns 1 if travelling within the same zone' do
      journey.start_journey(station2)
      journey.end_journey(station3)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
    it 'returns 2 if travelling from zone 1 to zone 2' do
      journey.start_journey(station1)
      journey.end_journey(station2)
      expect(journey.fare).to eq Journey::MINIMUM_FARE+1
    end
    it 'returns 6 for a incomplet journey' do
      journey.end_journey(station2)
      expect(journey.fare).to eq Journey::PENALTY
    end

  end

end