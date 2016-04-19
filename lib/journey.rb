class Journey

	attr_reader :card, :entry_station

	def initialize(card)
		@card = card
	end

	def start(entry_station)
		card.touch_in
		@entry_station = entry_station
	end

end