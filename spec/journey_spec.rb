require 'journey'

describe Journey do
    
  subject(:journey) { described_class.new }
  let(:station1) {double :station}
  let(:station2) {double :station}
  let(:card) {spy :card}
  
  describe '#end_journey' do
    it 'deducts a penalty fare if no entry station is not set' do
      journey.end_journey(station2,card)
      expect(card).to have_received(:deduct).with(Journey::PENALTY)
    end
    it 'deducts a standard fare if an entry station has been set' do
      journey.start_journey(station1,card)
      journey.end_journey(station2,card)
      expect(card).to have_received(:deduct).with(Journey::STANDARD_FARE)
    end
    it 'tells the card to log the journey' do
      journey.end_journey(station2,card)
      expect(card).to have_received(:add_to_log).with(nil,station2)
    end
    it 'resets the entry and exit stations ready for the next journey' do
      journey.start_journey(station1,card)
      journey.end_journey(station2,card)
      expect(journey.start_station).to eq nil
      expect(journey.end_station).to eq nil
    end
  end
  
  describe '#start_journey if entry station is already set' do
    it 'deducts penalty fare from card' do
      journey.start_journey(station1,card)
      journey.start_journey(station2,card)
      expect(card).to have_received(:deduct).with(Journey::PENALTY)
    end
    it 'tells the card to log the invalid journey' do
      journey.start_journey(station1,card)
      journey.start_journey(station2,card)
      expect(card).to have_received(:add_to_log).with(station1,nil)
    end
    it 'sets the new entry station' do
      journey.start_journey(station1,card)
      journey.start_journey(station2,card)
      expect(journey.start_station).to eq station2
    end
  end

  describe '#start_journey if entry station is not already set' do
    it 'does not deduct penalty fare' do
      journey.start_journey(station1,card)
      expect(card).not_to have_received(:deduct)
    end
    it 'does not tell the card to log the invalid journey' do
      journey.start_journey(station1,card)
      expect(card).not_to have_received(:add_to_log)
    end
  end

end