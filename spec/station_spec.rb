require 'station'

describe Station do 
	subject(:station) {described_class.new(:camden, 2)}
	it 'should return the stations zone' do
		expect(station.zone).to eq 2
	end
	it 'should return the stations name' do
		expect(station.name).to eq :camden
	end

end