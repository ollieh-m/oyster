require 'oystercard'

describe Oystercard do

	subject(:oystercard) {described_class.new}
	let(:entry_station) {double :station}
	let(:exit_station) {double :station}

	let(:oystercard_topped) do
		subject.top_up(Oystercard::MINIMUM_FARE)
		subject.touch_in(entry_station)
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
  			oystercard_topped.touch_out(exit_station)
  			expect(oystercard_topped).not_to be_in_journey
		end

		it 'oyster card is initially not in a journey' do
  			expect(oystercard).not_to be_in_journey
		end

		it 'fails to touch in if balance is below the minimum' do 
			expect{oystercard.touch_in(entry_station)}.to raise_error "balance must be at least £#{Oystercard::MINIMUM_FARE}"
		end

		it 'deducts minimum fare when touching out' do
			expect{oystercard_topped.touch_out(exit_station)}.to change{oystercard_topped.balance}.by -Oystercard::MINIMUM_FARE
		end
	end

	context 'storing journey information' do 
		# it 'records the station you touch in at' do 
		# 	expect(oystercard_topped.entry_station).to eq entry_station
		# end

		it 'resets the entry_station on touch out' do
			oystercard_topped.touch_out(exit_station)
			expect(oystercard_topped.entry_station).to eq nil
		end

		# it 'records the station you touch out at' do
		# 	oystercard_topped.touch_out(exit_station)
		# 	expect(oystercard_topped.exit_station).to eq exit_station
		# end

		it 'has no journeys stored when card is created' do
			expect(oystercard.journeys).to be_empty
		end

		it 'creates an entry in journeys with entry and exit stations stored in a hash' do
			journey = { entry_station: entry_station, exit_station: exit_station }
			oystercard_topped.touch_out(exit_station)
			expect(oystercard_topped.journeys).to include journey
		end
	end

end