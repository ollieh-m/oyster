require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }
  
  it 'defaults with balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'does not have an entry station' do
    expect(oystercard.entry_station).to be_nil
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
      oystercard.touch_in(station)
    end

    describe '#touch_in' do
    
      it ' touches in' do
        expect(oystercard).to be_in_journey
      end

      it 'remembers the station that was touched in' do
        expect(oystercard.entry_station).to eq station
      end
    
      it 'stores entry station when touched in' do 
        expect(oystercard.journey_history.last[:start_station]).to eq station
      end
    end
    
    describe '#touch_out' do
      
      before do 
        oystercard.touch_out(station2)
      end
      
      it '#touch_out' do
        expect(oystercard).not_to be_in_journey
      end
    
      it 'records the station it was touched out at' do
        expect(oystercard.journey_history.last[:exit_station]).to eq station2
      end

      it 'deducts minimum fare on touch out' do
        expect(oystercard.balance).to eq(Oystercard::MAX_LIMIT - 1)
      end

      it 'removes entry station on touch out' do
        expect(oystercard.entry_station).to be_nil
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