require 'journeylog'

describe Journeylog do

	let(:current_journey1){ double(:journey, start_station: "Chalk Farm", end_station: "Camden", entry_station?: true, start_journey: nil, end_journey: nil, reset: nil) }
	let(:current_journey2){ double(:journey, start_station: "Chalk Farm", end_station: "Camden", entry_station?: false, start_journey: nil)}
	let(:card){ spy(:card) }
	let(:station){ double(:station) }

	context '#begin' do
		it 'deducts from the card if an entry station has already been set in current_journey' do
			journey_log = Journeylog.new(current_journey1)
			journey_log.begin(station,card)
			expect(card).to have_received(:deduct).with(current_journey1)
		end
		it 'puts the current station in the journey history if an entry station has already been set' do
			journey_log = Journeylog.new(current_journey1)
			journey_log.begin(station,card)
			expect(journey_log.journey_history).to include({entrystation: current_journey1.start_station, exitstation: current_journey1.end_station})
		end
		it 'does not deduct from the card in an entry station hasn\'t been set' do
			journey_log = Journeylog.new(current_journey2)
			journey_log.begin(station,card)
			expect(card).not_to have_received(:deduct).with(current_journey2)
		end
		it 'does not put the current station in the journey history if an entry station has not already been set' do
			journey_log = Journeylog.new(current_journey2)
			journey_log.begin(station,card)
			expect(journey_log.journey_history).not_to include({entrystation: current_journey2.start_station, exitstation: current_journey2.end_station})
		end
		it 'calls start_journey on the current station to update its entry station' do
			journey_log = Journeylog.new(current_journey1)
			expect(current_journey1).to receive(:start_journey).with(station)
			journey_log.begin(station,card)
		end
	end

	context '#finish' do
		it 'sets the exit station within the current station' do
			journey_log = Journeylog.new(current_journey1)
			expect(current_journey1).to receive(:end_journey).with(station)
			journey_log.finish(station,card)
		end
		it 'calls deduct on the card' do
			journey_log = Journeylog.new(current_journey1)
			journey_log.finish(station,card)
			expect(card).to have_received(:deduct).with(current_journey1)
		end
		it 'adds the current journey to the journey history' do
			journey_log = Journeylog.new(current_journey1)
			journey_log.finish(station,card)
			expect(journey_log.journey_history).to include({entrystation: current_journey2.start_station, exitstation: current_journey2.end_station})
		end
		it 'resets current journey' do
			journey_log = Journeylog.new(current_journey1)
			expect(current_journey1).to receive(:reset)
			journey_log.finish(station,card)
		end
	end

end