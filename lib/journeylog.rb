class Journeylog

	attr_reader :journey_history, :current_journey

	def initialize(current_journey=Journey.new)
		@current_journey = current_journey
		@journey_history = []
	end

	def begin(station,card)
		if current_journey.entry_station?
			card.deduct(current_journey.fare)
			update_history
		end
		current_journey.start_journey(station)
	end

	def finish(station,card)
		current_journey.end_journey(station)
		card.deduct(current_journey.fare)
		update_history
		current_journey.reset
	end

		private

		def log_details
			{entrystation: current_journey.start_station, exitstation: current_journey.end_station}
		end

		def update_history
			@journey_history << log_details
		end

end