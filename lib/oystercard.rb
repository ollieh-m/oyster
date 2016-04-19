
class Oystercard

	attr_reader :balance, :entry_station, :exit_station, :journeys

	MAXIMUM_BALANCE = 90

  MINIMUM_FARE = 1

	def initialize
		@balance = 0
    @journeys = []
	end

	def top_up(amount)
    fail "Maximum balance #{MAXIMUM_BALANCE}exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(journey)
    fail "balance must be at least £#{MINIMUM_FARE}" if balance < MINIMUM_FARE
    journey.levy_penalty if @in_use
  	@in_use = true
  end

  def touch_out(journey)
    journey.levy_penalty if !@in_use
  	@in_use = false
    @journeys[0] = { entry_station: @entry_station, exit_station: @exit_station }
  end

  def in_journey?
  	@in_use #!!entry_station
  end

  def complete(entry_station, exit_station)
    @journeys << { entry_station: entry_station, exit_station: exit_station }
  end

    private

    def deduct(amount)
      @balance -= amount
    end

end