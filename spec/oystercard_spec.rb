require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }
  let(:journey) { double(:journey) }
  let(:unfinished_business) { double(:journey, ended?: false) }
  
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
    
      it 'records a journey into journey history' do
        oystercard.touch_in(journey)
        expect(oystercard.journey_history.last).to eq journey
      end
      
      it 'applies a penalty fare if card hasn\'t been touched out' do
        oystercard.touch_in(unfinished_business)
        expect { oystercard.touch_in(journey) }.to change{ oystercard.balance }.by(-6)
      end
      
    end
    
    describe '#touch_out' do
      
      before do 
        oystercard.touch_out(station2)
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