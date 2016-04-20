require 'oystercard'

describe Oystercard do

	subject(:oystercard){ described_class.new }
	let(:journey){ spy :journey }

	let(:oystercard_topped) do
		subject.top_up(Oystercard::MINIMUM_FARE)
		subject.touch_in(journey)
		subject
	end

	context 'when initializing a card' do
		it 'should have a balance of 0' do
			expect(oystercard.balance).to eq(0)
		end
	end

	context 'when topping up balance' do
		it 'adds money to the balance on oystercard'do 
			expect{oystercard.top_up 1}.to change{oystercard.balance}.by 1
		end
		it 'raises an expection if the balance goes above the maximum balance' do 
			max_bal = Oystercard::MAXIMUM_BALANCE
    		subject.top_up(max_bal)
    		expect{ subject.top_up 1 }.to raise_error "Maximum balance £#{max_bal} exceeded"
		end
	end

	context 'when touching in and out' do
		it "can touch in if the card's balance has been set to at least the minimum fare" do
  			expect(oystercard_topped).to be_in_journey
		end
		it "fails to touch in if the card's balance is below the minimum fare" do 
			min_fare = Oystercard::MINIMUM_FARE
			expect{oystercard.touch_in(journey)}.to raise_error "balance must be at least £#{min_fare}"
		end
		it 'tells the journey to levy a penalty when trying to touch in if already touched in' do 
			expect(journey).to receive(:levy_penalty)
			oystercard_topped.touch_in(journey)
		end
		it 'can touch out' do
  			oystercard_topped.touch_out(journey)
  			expect(oystercard_topped).not_to be_in_journey
		end
		it 'oyster card is initially not in a journey' do
  			expect(oystercard).not_to be_in_journey
		end
		it 'tells the journey to levy_penalty when trying to touch_out if not touched in' do 
			oystercard.touch_out(journey)
			expect(journey).to have_received(:levy_penalty)
		end
	end

	context 'storing a completed journey' do 
		let(:entry_station) {double :station}
		let(:exit_station) {double :station}

		it '#complete stores a completed journey' do
			oystercard.complete(entry_station, exit_station)
			expect(oystercard.journeys).to include({:entry_station => entry_station, :exit_station => exit_station})
		end
	end
end