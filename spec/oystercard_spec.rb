require 'oystercard'

describe Oystercard do

	subject(:oystercard) {described_class.new}
	let(:journey) {double :journey, :levy_penalty => nil}

	let(:oystercard_topped) do
		subject.top_up(Oystercard::MINIMUM_FARE)
		subject.touch_in(journey)
		subject
	end

	it 'I want an oystercard with a balance of 0' do
		expect(oystercard.balance).to eq(0)
	end

	context 'when topping up balance' do
		it 'response to top up with 1 argument' do
			expect(oystercard).to respond_to(:top_up).with(1).argument
		end

		it 'adds money to the balance on oystercard'do 
			expect{oystercard.top_up 1}.to change{oystercard.balance}.by 1
		end

		it 'raises an expection if the balance goes above £90' do 
			MAXIMUM_BALANCE = Oystercard::MAXIMUM_BALANCE
    		subject.top_up(MAXIMUM_BALANCE)
    		expect{ subject.top_up 1 }.to raise_error "Maximum balance #{MAXIMUM_BALANCE}exceeded"
		end
	end

	context 'when touching in and out' do
		it "can touch in with at least £1 in balance" do
  			expect(oystercard_topped).to be_in_journey
		end

		it 'can touch out' do
  			oystercard_topped.touch_out(journey)
  			expect(oystercard_topped).not_to be_in_journey
		end

		it 'oyster card is initially not in a journey' do
  			expect(oystercard).not_to be_in_journey
		end

		it 'fails to touch in if balance is below the minimum' do 
			expect{oystercard.touch_in(journey)}.to raise_error "balance must be at least £#{Oystercard::MINIMUM_FARE}"
		end

		it 'tells journey to levy penalty when already touched in' do 
			expect(journey).to receive(:levy_penalty)
			oystercard_topped.touch_in(journey)
		end

		it 'tells journey to levy_penalty when trying to touch_out if not touched in' do 
			expect(journey).to receive(:levy_penalty)
			oystercard.touch_out(journey)
		end
	end

	context 'store a completed journey' do 
			let(:entry_station) {double :station}
			let(:exit_station) {double :station}
		it 'stores a completed journey' do
			oystercard.complete(entry_station, exit_station)
			expect(oystercard.journeys).to include({:entry_station => entry_station, :exit_station => exit_station})
		end
	end
end