require 'oystercard'

describe Oystercard do

	subject(:oystercard) {described_class.new}
	let(:station) {double :station}
	let(:oystercard_topped) do
		subject.top_up(Oystercard::MINIMUM_FARE)
		subject.touch_in(station)
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
  			oystercard_topped.touch_out
  			expect(oystercard_topped).not_to be_in_journey
		end

		it 'oyster card is initially not in a journey' do
  			expect(oystercard).not_to be_in_journey
		end

		it 'fails to touch in if balance is below the minimum' do 
			expect{oystercard.touch_in(station)}.to raise_error "balance must be at least £#{Oystercard::MINIMUM_FARE}"
		end

		it 'deducts minimum fare when touching out' do
			expect{oystercard_topped.touch_out}.to change{oystercard_topped.balance}.by -Oystercard::MINIMUM_FARE
		end
	end

	context 'storing journy information' do 
		it 'it records the station you check in at' do 
			expect(oystercard_topped.entry_station).to eq station
		end

		it 'it resets the entry_station on touch out' do
			oystercard_topped.touch_out
			expect(oystercard_topped.entry_station).to eq nil
		end

	end

end