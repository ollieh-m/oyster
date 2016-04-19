require 'journey'

describe Journey do
	let(:card){ double :card, :touch_in => nil }
	let(:entry_station){ double :station }
	subject(:journey){ described_class.new(card) }

	context 'starting a journey' do
		it '#start calls touch_in on card' do
			expect(card).to receive(:touch_in)
			journey.start(entry_station)
		end
		it '#start stores the entry station' do
			journey.start(entry_station)
			expect(journey.entry_station).to eq entry_station
		end
	end
	
end