require 'journey'

describe Journey do
	let(:card){ double :card, :touch_in => nil, :touch_out => nil, :deduct => nil, :complete => nil}
	let(:entry_station){ double :station }
	let(:exit_station) {double :station}
	subject(:journey){ described_class.new(card) }

	context 'starting a journey' do
		it '#start calls touch_in on card' do
			expect(card).to receive(:touch_in).with(journey)
			journey.start(entry_station)
		end
		it '#start stores the entry station' do
			journey.start(entry_station)
			expect(journey.entry_station).to eq entry_station
		end
	end
	
	context 'ending a journey' do
		it '#end calls touch_out on card' do
			expect(card).to receive(:touch_out).with(journey)
			journey.end(exit_station)
		end

		it '#end stores the exit station' do
			journey.end(exit_station)
			expect(journey.exit_station).to eq exit_station
		end

		it '#end charges the fare to the card' do 
			expect(card).to receive(:deduct).with(journey.fare)
			journey.end(exit_station)
		end

		it '#end it confirms the completion of a journey' do 
			expect(card).to receive(:complete).with(entry_station, exit_station)
			journey.start(entry_station)
			journey.end(exit_station)
		end

	end

	context 'adding penalty fare to fare' do
		it '#levy_penalty adds 5 fare' do 
			expect{journey.levy_penalty}.to change{journey.fare}.by 5
		end

	end


end