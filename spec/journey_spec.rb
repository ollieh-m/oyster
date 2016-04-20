require 'journey'

describe Journey do
	let(:card){ spy :card }
	let(:entry_station){ double :station }
	let(:exit_station) { double :station }
	subject(:journey){ described_class.new(card) }

	context 'starting a journey' do
		it '#start calls touch_in on card' do
			journey.start(entry_station)
			expect(card).to have_received(:touch_in).with(journey)
		end
	end
	
	context 'ending a journey' do
		it '#end calls touch_out on card' do
			journey.end(exit_station)
			expect(card).to have_received(:touch_out).with(journey)
		end
		it '#end charges the fare to the card' do 
			journey.end(exit_station)
			expect(card).to have_received(:deduct).with(journey.fare)
		end
		it '#end confirms the completion of a journey' do 
			journey.start(entry_station)
			journey.end(exit_station)
			expect(card).to have_received(:complete).with(entry_station, exit_station)
		end
		it '#end passes nil to the card as the entry station if a journey ends before it has started' do
			journey.start(entry_station)
			journey.end(exit_station)
			journey.end(exit_station)
			expect(card).to have_received(:complete).with(nil, exit_station)
		end
	end

	context 'adding penalty fare to fare' do
		it '#levy_penalty adds 5 fare' do 
			expect{journey.levy_penalty}.to change{journey.fare}.by 5
		end
	end


end