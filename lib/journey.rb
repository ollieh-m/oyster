class Journey

	attr_reader :card, :entry_station, :exit_station

	MINIMUM_FARE = 1

	def initialize(card)
		@card = card
		@fare = MINIMUM_FARE
	end

	def start(entry_station)
		card.touch_in(self)
		@entry_station = entry_station
	end

	def end(exit_station)
		card.touch_out(self)
		@exit_station = exit_station
		finalise_journey
	end

	def levy_penalty
		@fare += 5
	end

	def fare
		@fare
	end

	def finalise_journey
		card.deduct(fare)
		card.complete(entry_station,exit_station)
	end


end